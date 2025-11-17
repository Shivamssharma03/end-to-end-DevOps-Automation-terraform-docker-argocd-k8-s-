# Deploy Argo CD & NGINX Ingress via Ansible
## Install Ingress Controller
```bash
ansible-playbook -i inventory.ini install-ingress.yaml
```
## Check Ingress installation:
```bash
kubectl get pods -n ingress-nginx
kubectl get svc -n ingress-nginx
```

## Install ArgoCD
```bash
ansible-playbook -i inventory.ini install-argocd.yaml
```
## Verify installation:

```bash
kubectl get pods -n argocd
kubectl get svc -n argocd
```


## After Installation
## Get NodePort/LoadBalancer for ArgoCD:
```bash
kubectl get svc -n argocd
```

# Get Argo CD Login Credentials

## Get the initial admin password:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```



# Run the Playbook for certmanager installation
```bash
ansible-playbook -i inventory.ini install-certmanager.yml
```
# Verify Cert-Manager Installation:
```bash
`kubectl get pods -n cert-manager
```


# Run the Playbook for install-reloader.yml
```bash
ansible-playbook -i inventory.ini install-reloader.yml
```
# for creating the env secrect
```bash
ansible-playbook -i inventory.ini create-backend-secret.yml
```
# for providing the certificates 
```bash
ansible-playbook -i inventory.ini create-cluster-issuer.yml
```

# for hpa install the metric server on cluster cluster
```bash
`ansible-playbook -i inventory.ini install-metric-server.yml`
```

# After installation, verify:
```bash
kubectl top nodes
kubectl top pods
```
If you get CPU/Memory usage → Metrics Server is working.