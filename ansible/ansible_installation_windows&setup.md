# Install Ansible on Windows (Using WSL) & Connect to EKS Cluster

This guide shows how to install Ansible on a Windows system using WSL (Ubuntu) and connect it to an Amazon EKS Kubernetes cluster.

---

##  Install WSL (Ubuntu)

Open **PowerShell as Administrator** and run:


```**powershell**```
`wsl --install`


Restart your computer and open **Ubuntu** from the Start Menu.

---

##  Update Ubuntu Packages

Inside Ubuntu terminal:

```bash
sudo apt update && sudo apt upgrade -y
```

---

##  Install Ansible

```bash
sudo apt install ansible -y
ansible --version
```

---

##  Install Python Kubernetes Modules

```bash
pip install kubernetes openshift
```

---

##  Install AWS CLI in Ubuntu

```bash
sudo apt install awscli -y
```

Configure AWS credentials:

```bash
aws configure
```

Enter:
- AWS Access Key
- AWS Secret Key
- AWS Region
- Output: json

---

##  Install kubectl

```bash
sudo apt install -y kubectl
kubectl version --client
```

---

##  Connect to Your EKS Cluster

Replace CLUSTER_NAME and REGION:

```bash
aws eks update-kubeconfig --name CLUSTER_NAME --region REGION
```

Example:

```bash
aws eks update-kubeconfig --name my-eks-cluster --region ap-south-1
```

---

##  Verify Connection

```bash
kubectl get nodes
```

 If nodes appear, connection is successful and Ansible can manage the cluster.

---

##  Done!

You now have:
✔ Ansible installed on Windows  
✔ AWS CLI configured  
✔ kubectl connected to EKS  
✔ Ready to run Ansible playbooks for Kubernetes
