# Linux, Docker, and Kubernetes

## Linux

The Linux kernel manages hardware and memory and files and processes. Applications run in user space and use the kernel to access these resources. A distribution adds tools, libraries and a package manager. Ubuntu and Debian use `apt`; Red Hat Enterprise Linux, Fedora, Rocky Linux, and AlmaLinux use `dnf`; SUSE uses `zypper`.

Linux directories start at `/`. Common directories include `/home` for users' files, `/root` for the root user's home, `/etc` for configuration, `/var` for logs and changing data, `/usr` for installed programs and libraries, `/tmp` for temporary files, `/dev` for device interfaces, and `/proc` and `/sys` for kernel information.

## Docker

Docker runs applications in containers. An image contains the application and its dependencies; a container runs that image. Containers share the host kernel. Registries such as Docker Hub store and distribute images. Volumes keep data, and container networks connect services.

Docker is used to run services, set up development environments and build applications. This assignment builds a Tomcat 9 image with a sample WAR and runs Nginx and PostgreSQL containers.

Commands (PowerShell):

```powershell
docker version
docker pull nginx:alpine
docker images
docker ps
docker logs assignment-nginx
docker exec -it assignment-nginx sh
docker stop assignment-nginx
docker build -t ps-tomcat-webapp:1.0 .
docker login
docker push abdallah6868/ps-tomcat-webapp:1.0
```

`Dockerfile` in `docker/tomcat-war/` packages the sample app as `ROOT.war` in Tomcat. Build the image from that directory.

## Kubernetes

Kubernetes keeps container Applications running across nodes. It starts Pods and replaces failed ones. A Deployment keeps the requested number of Pods running; a Service provides a network endpoint for them.

The control plane (called the master in older material) manages the cluster through the API server, scheduler, controller manager, and `etcd`. **Worker nodes** run application Pods. A local cluster can combine both roles on one node. `kubectl get nodes` lists nodes and their roles; `Ready` indicates that a node is healthy enough to run workloads. Worker nodes may show `<none>` in the role column. Check node labels with `kubectl describe node`. A control-plane node is commonly labelled `control-plane`.

Docker Desktop ran the Tomcat deployment with one Pod on port 8080.

Deployment commands and the manifest are in `kubernetes/`.
