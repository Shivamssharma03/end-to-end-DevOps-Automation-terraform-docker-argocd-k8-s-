
# 🚀 Cluster Autoscaler – Quick GitHub Version (Commands Only)

This README provides **only commands**, no YAML files.

---

## 🧩 1. Verify NodeGroup Autoscaler Tags (Terraform)
Ensure your node group has these tags in Terraform:

```
k8s.io/cluster-autoscaler/enabled = "true"
k8s.io/cluster-autoscaler/<cluster-name> = "owned"
```

---

## 🔐 2. Verify IAM Policy Attached to Node Role
Node role must include autoscaler permissions:

```
autoscaling:DescribeAutoScalingGroups
autoscaling:SetDesiredCapacity
autoscaling:TerminateInstanceInAutoScalingGroup
ec2:DescribeLaunchTemplateVersions
```

---

## 🛠 3. Apply Autoscaler Manifest
```
kubectl apply -f cluster-autoscaler.yml
```

---

## 🔍 4. Verify Autoscaler Pod
```
kubectl get pods -n kube-system | grep autoscaler
```

---

## 📜 5. Check Autoscaler Logs
```
kubectl logs -n kube-system -f deployment/cluster-autoscaler
```

---

## 🔎 6. Confirm Autoscaler Found NodeGroup
```
kubectl logs -n kube-system deployment/cluster-autoscaler | grep -i "node group"
```

---

## 📈 7. Watch Node Scaling
```
kubectl get nodes -w
```

---

## 🔧 8. Update Kubeconfig (Important)
```
aws eks update-kubeconfig --region <region> --name <cluster-name>
```

---

## 🧪 9. Generate Load to Trigger Scaling
```
kubectl run load --image=busybox -- /bin/sh -c "while true; do wget -q -O- http://frontend-svc; done"
```
http://frontend-svc is svc name of the frontend service 
--- 

## 🧹 10. Cleanup Load Generator
```
kubectl delete pod load
```

---

## 🛑 11. Destroy Infra (Terraform)
```
terraform destroy -auto-approve
```

---

🎉 Your Cluster Autoscaler setup is complete!
