# Deploy Argo CD & NGINX Ingress via Ansible
## Install Ingress Controller

`ansible-playbook -i inventory.ini install-ingress.yaml`

## Check Ingress installation:

`kubectl get pods -n ingress-nginx`
`kubectl get svc -n ingress-nginx`


## Install ArgoCD

`ansible-playbook -i inventory.ini install-argocd.yaml`

## Verify installation:


`kubectl get pods -n argocd`
`kubectl get svc -n argocd`



## After Installation
## Get NodePort/LoadBalancer for ArgoCD:

`kubectl get svc -n argocd`


# Get Argo CD Login Credentials

## Get the initial admin password:

`kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d`




# Run the Playbook for certmanager installation

`ansible-playbook -i inventory.ini install-certmanager.yml`

# Verify Cert-Manager Installation

`kubectl get pods -n cert-manager`



# Run the Playbook for install-reloader.yml
`ansible-playbook -i inventory.ini install-reloader.yml`

# for creating the env secrect
`ansible-playbook -i inventory.ini create-backend-secret.yml`

# for propviding thecertificates 
`ansible-playbook -i inventory.ini create-cluster-issuer.yml`