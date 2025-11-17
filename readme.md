# ☕ — Full-Stack Kubernetes Deployment on AWS EKS  
### Automated Infrastructure with **Terraform + Ansible + ArgoCD + NGINX + Cert-Manager + Docker + Kubernetes**

---

## 🏗️ Project Overview

| Component | Description |
|------------|-------------|
| **Frontend** | React app served via NGINX |
| **Backend** | Node.js + Express + MongoDB Atlas |
| **Database** | MongoDB Atlas Cluster |
| **Infrastructure** | Provisioned using Terraform (EKS, VPC, IAM, OIDC, Nodes) |
| **Configuration Management** | Ansible used for installing Ingress Controller, Cert-Manager, ArgoCD, Reloader, and ClusterIssuer |
| **Ingress Controller** | NGINX with TLS via Let’s Encrypt |
| **Secrets Reload** | Stakater Reloader |
| **CI/CD** | GitOps with ArgoCD |
| **Cluster** | Amazon EKS (Private Cluster) |

---

## 🧩 Architecture Overview

erraform (Infrastructure)
│
├── AWS VPC, Subnets, Security Groups
├── EKS Cluster & Node Groups
├── OIDC Provider (for IRSA)
└── Outputs: kubeconfig, cluster CA, endpoint
↓
Ansible (Cluster Setup)
│
├── NGINX Ingress Controller
├── Cert-Manager + ClusterIssuer (Let's Encrypt)
├── Stakater Reloader
├── ArgoCD (GitOps)
└── Backend Secret creation
↓
Kubernetes Workloads
│
├── Frontend (React + NGINX)
├── Backend (Node.js + Express + MongoDB Atlas)
└── Ingress routing (tesify.site / api.tesify.site)

---

## ⚙️ Repository Structure


├── Infrastructure/
│ ├── main.tf
│ ├── variables.tf
│ ├── outputs.tf
│ └── modules/
│ ├── vpc/
│ ├── eks/
│ └── iam/
│
├── ansible/
│ ├── install-nginx-ingress.yml
│ ├── install-cert-manager.yml
│ ├── create-cluster-issuer.yml
│ ├── install-argocd.yml
│ ├── install-reloader.yml
│ ├── secret-volume-create.yml
│ └── install-metric-server.yml
  └── inventory.yml (localhost)
│
└── ingress/
├── info-ingress.yaml
k8s/
 ├── backend-deployment.yml
 ├──backend-hpa.yml
 ├── backend-service.yml
 ├── frontend-deployment.yml
 ├──frontend-hpa.yml
 ├── frontend-service.yml

---

## 🚀 Deployment Workflow

### 1️⃣ Provision Infrastructure using Terraform

```bash
cd terraform/
terraform init
terraform plan -var-file="envs/dev.tfvars" 
terraform apply -var-file="envs/dev.tfvars" -auto-approve
```
Creates:

AWS VPC

EKS Cluster & Node Groups

IAM Roles

Security Groups, Subnets

# Configure kubeconfig
```bash
aws eks update-kubeconfig --name eks-pvt-cluster --region eu-north-1
kubectl get nodes
```

# Deploy Core Components with Ansible

for refrence check readme.md in ansible folder 
# Deploying and attcher deployment and services file both frontend and backend sync via argo cd 
check readme.md in ansible folder 

# Deploy Application Ingress Rules
`kubectl apply -f ingress/info-ingress.yaml -n tesify-ingress-route`

tesify.site → Frontend Service
api.tesify.site → Backend Service


Check:
`kubectl get ingress -n tesify-ingress-route`



# Verification after deploying the deployements and services manifests :
for checking pods 
`kubectl get pods -n tesify-ingress-route`
for ingress
`kubectl get ingress -n tesify-ingress-route`

for certification
`kubectl describe clusterissuer letsencrypt-prod`


✅ Check TLS certificate:

`kubectl get certificate -n tesify-ingress-route`


✅ Test backend health:

`curl -k https://api.tesify.site/api/health`


✅ Access frontend:

open `https://tesify.site`



🧰 Tech Stack Summary
Category	Technology
Infrastructure as Code	Terraform
Configuration Management	Ansible
Container Orchestration	Kubernetes (Amazon EKS)
Ingress Controller	NGINX
SSL/TLS Automation	Cert-Manager + Let’s Encrypt
CI/CD (GitOps)	ArgoCD
Secrets Reloading	Stakater Reloader
Database	MongoDB Atlas
Backend	Node.js + Express
Frontend	React + NGINX
🧑‍💻 Author

Shivam Sharma
📧 sshivam03sharma@gmail.com
