# Tomcat Docker image

this dockerfile uses Tomcat 9 with Java 8. It creates `ROOT.war` from the sample app and puts it in Tomcat's `webapps` directory.

Run the commands from folder:

```powershell
docker build -t ps-tomcat-webapp:1.0 .
docker run -d --name assignment-tomcat -p 127.0.0.1:7070:8080 ps-tomcat-webapp:1.0
```

Open `http://127.0.0.1:7070/`.

The image was pushed to Docker Hub using:

```powershell
docker login
docker tag ps-tomcat-webapp:1.0 abdallah6868/ps-tomcat-webapp:1.0
docker push abdallah6868/ps-tomcat-webapp:1.0
```
