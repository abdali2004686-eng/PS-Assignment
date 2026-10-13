FROM tomcat:9-jdk8-temurin

WORKDIR /tmp/sample-webapp
COPY sample-app/ ./

# Package the sample web application as a WAR inside the image.
RUN jar -cf /usr/local/tomcat/webapps/ROOT.war . \
    && rm -rf /tmp/sample-webapp

EXPOSE 8080
