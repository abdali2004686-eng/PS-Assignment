#!/usr/bin/env bash
set -euo pipefail

export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y ca-certificates curl gpg wget apt-transport-https nginx

# Install Java 8
if ! dpkg-query -W -f='${Status}' temurin-8-jdk 2>/dev/null | grep -q 'install ok installed'; then
  wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public \
    | gpg --dearmor -o /etc/apt/trusted.gpg.d/adoptium.gpg
  codename="$(. /etc/os-release; printf '%s' "$VERSION_CODENAME")"
  printf 'deb https://packages.adoptium.net/artifactory/deb %s main\n' "$codename" \
    > /etc/apt/sources.list.d/adoptium.list
  apt-get update
  apt-get install -y temurin-8-jdk
fi

TOMCAT_VERSION=9.0.123
TOMCAT_ARCHIVE="apache-tomcat-${TOMCAT_VERSION}.tar.gz"
TOMCAT_URL="https://archive.apache.org/dist/tomcat/tomcat-9/v${TOMCAT_VERSION}/bin/${TOMCAT_ARCHIVE}"

if ! id tomcat >/dev/null 2>&1; then
  useradd --system --home /opt/tomcat --shell /usr/sbin/nologin tomcat
fi

if [[ ! -f /opt/tomcat/bin/catalina.sh ]]; then
  curl -fL "$TOMCAT_URL" -o "/tmp/$TOMCAT_ARCHIVE"
  curl -fL "${TOMCAT_URL}.sha512" -o "/tmp/${TOMCAT_ARCHIVE}.sha512"
  (cd /tmp && sha512sum -c "${TOMCAT_ARCHIVE}.sha512")
  mkdir -p /opt/tomcat
  tar -xzf "/tmp/$TOMCAT_ARCHIVE" -C /opt/tomcat --strip-components=1
  rm -f "/tmp/$TOMCAT_ARCHIVE" "/tmp/${TOMCAT_ARCHIVE}.sha512"
fi

sed -i 's/port="8080"/port="7070"/' /opt/tomcat/conf/server.xml
chown -R tomcat:tomcat /opt/tomcat

# Set JAVA_HOME
JAVA_HOME="$(dirname "$(dirname "$(readlink -f "$(command -v javac)")")")"
# Deploy the WAR
if [[ -d /vagrant/sample-app ]]; then
  "$JAVA_HOME/bin/jar" -cf /opt/tomcat/webapps/ROOT.war -C /vagrant/sample-app .
  chown tomcat:tomcat /opt/tomcat/webapps/ROOT.war
fi

cat > /etc/systemd/system/tomcat.service <<EOF
[Unit]
Description=Apache Tomcat 9
After=network.target

[Service]
Type=forking
User=tomcat
Group=tomcat
Environment=JAVA_HOME=$JAVA_HOME
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable --now tomcat

cat > /etc/nginx/sites-available/tomcat-reverse-proxy <<'NGINX'
server {
    listen 80 default_server;
    listen [::]:80 default_server;
    server_name tomcat.localhost;

    location / {
        proxy_pass http://127.0.0.1:7070;
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
NGINX
ln -sfn /etc/nginx/sites-available/tomcat-reverse-proxy /etc/nginx/sites-enabled/tomcat-reverse-proxy
rm -f /etc/nginx/sites-enabled/default
nginx -t
systemctl enable --now nginx
systemctl restart nginx

java -version
/opt/tomcat/bin/version.sh
systemctl is-active tomcat
systemctl is-active nginx
