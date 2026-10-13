# Linux tasks

## 1. Display system information

```bash
sudo apt update
sudo apt install -y curl iproute2 procps util-linux
sudo hostnamectl set-hostname postgres02
sudo timedatectl set-timezone Etc/UTC
bash -n linux/system_info.sh
chmod +x linux/system_info.sh
sudo ./linux/system_info.sh
```

## 2. Create the user and groups

```bash
sudo groupadd -f PSgroup
sudo groupadd -f dba
sudo useradd -m -s /bin/bash -g PSgroup -G dba PS
sudo passwd PS
id PS
```

## 3. Change the root password

```bash
sudo passwd root
sudo passwd -S root
```

## 4. Install MySQL and HAProxy

```bash
sudo apt update
sudo apt install -y mysql-server haproxy
sudo systemctl enable --now mysql haproxy
systemctl is-active mysql
systemctl is-active haproxy
mysql --version
haproxy -v
sudo mysql -e 'SELECT VERSION();'
```

## 5. Allow inbound TCP and UDP on port 3306

```bash
sudo apt install -y ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 3306/tcp
sudo ufw allow 3306/udp
sudo ufw enable
sudo ufw status verbose
```

## 6. Copy a file from Windows to Ubuntu

```bash
cp /media/sf_PSAssignment/linux/system_info.sh ~/system_info.sh
ls -l ~/system_info.sh
sudo bash ~/system_info.sh
```

## 6a. SCP and SFTP guest setup

```bash
sudo apt install -y openssh-server
sudo systemctl enable --now ssh
sudo ufw allow 22/tcp
```

## 6b. VirtualBox NAT SSH forwarding Windows VM powered off

```powershell
VBoxManage modifyvm "ubuntu" --natpf1 "ssh,tcp,127.0.0.1,2223,,22"
```

## 6c. Copy using SCP Windows

```powershell
scp -P 2223 .\example.txt abd@127.0.0.1:/home/abd/
```

## 6d. Copy using SFTP Windows

```powershell
sftp -P 2223 abd@127.0.0.1
```

```text
put example.txt
bye
```

## 6e. FTP and FTPS Windows requires an FTP server and forwarded ports

```powershell
curl.exe --user PS -T .\example.txt ftp://SERVER:PORT/
curl.exe --ssl-reqd --user PS -T .\example.txt ftp://SERVER:PORT/
```

## 6f. Vagrant synced folder guest

```bash
cp /vagrant/sample-app/index.html ~/index.html
```

## 6g. Restore the Linux SSH firewall rule after transfer

```bash
sudo ufw delete allow 22/tcp
sudo ufw status verbose
```
## Linux checks

```bash
cat /etc/os-release
sudo bash ~/system_info.sh
id PS
sudo passwd -S root
systemctl is-active mysql haproxy
sudo ufw status verbose
ls -l ~/system_info.sh
```
