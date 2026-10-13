# Nginx and PostgreSQL containers

## Nginx

```powershell
docker run -d --name assignment-nginx -p 127.0.0.1:8081:80 nginx:alpine
```

Open http://127.0.0.1:8081/.

## PostgreSQL

```powershell
$env:POSTGRES_PASSWORD = Read-Host "PostgreSQL password"
docker volume create assignment-postgres-data
docker run -d --name assignment-postgres -e POSTGRES_PASSWORD -v assignment-postgres-data:/var/lib/postgresql/data -p 127.0.0.1:5432:5432 postgres:17
Remove-Item Env:POSTGRES_PASSWORD
```

The volume keeps the database files when the container is replaced. These run commands are for creating new containers; existing assignment containers do not need to be recreated.

## Check

```powershell
docker ps
docker exec assignment-postgres pg_isready -U postgres
```
