# Tomcat VM

install Vagrant and VirtualBox,  open PowerShell in this folder:

```powershell
vagrant up --provider virtualbox
vagrant ssh
```

Vagrantfile uses `bento/ubuntu-24.04`, 2048 MB RAM and one CPU. the script installs Java 8, Tomcat 9 and Nginx. It builds the sample app as `ROOT.war`.

tomcat uses guest port 7070, forwarded to host port 9090. Nginx uses port 80, also forwarded to host port 80.

On Windows, open `http://127.0.0.1:9090/` for Tomcat.

for Nginx, open `http://tomcat.localhost/`. If the name does not work, edit `C:\Windows\System32\drivers\etc\hosts` as Administrator and add:

```text
127.0.0.1 tomcat.localhost
```

Host port 80 must be free. This VM is separate from the Ubuntu desktop VM used for the Linux tasks.
