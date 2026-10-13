# Kubernetes deployment

Enable Kubernetes in Docker Desktop settings and wait for the cluster to be ready.

Run from the assignment folder:

```powershell
kubectl config use-context docker-desktop
kubectl get nodes -o wide
kubectl apply -f kubernetes/tomcat-demo.yaml
kubectl rollout status deployment/tomcat-demo
kubectl get deployments,pods,services
kubectl port-forward service/tomcat-demo 8080:8080
```

Open http://127.0.0.1:8080/. Press Ctrl+C to stop forwarding.
