# Alma k8s cluster


## Pre-requisites
- `sudo apt-get install sshpass` *Or the `sshpass` package is required in your system to be able to run ssh commands with a plain-text password.

```
cd alma-k8s
ansible all -m ping -v --extra-vars "cluster_password=$CLUSTER_PASSWORD"
```

## Running playbook
This could be the first run since you dont have nopassword in visudo the first time you create the cluster.
```
ansible-playbook site.yml --extra-vars "cluster_password=$CLUSTER_PASSWORD ansible_sudo_pass=$CLUSTER_PASSWORD"
```
After having run the second time you may only use
```
ansible-playbook site.yml --extra-vars "cluster_password=$CLUSTER_PASSWORD"
```

### Argo CD installation

```
export ARGOCD_VERSION=<desired argo cd release version (e.g. v2.7.0)>
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/$ARGOCD_VERSION/manifests/install.yaml
```