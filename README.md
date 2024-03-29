# Alma k8s cluster
**This is still working in progress. following [this blog post](https://www.linuxtechi.com/install-kubernetes-on-rockylinux-almalinux/)**
Creating the cluster

```
export controller=`Your DNS record for controller`
kubeadm init --control-plane-endpoint=${controller}
```

Getting Your kubeconfig from controller plane.

```
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```
Joining the worker node to cluster, usually this is going to be output from the previous `kubeadm init` command

```
kubeadm join ${controller}:6443 --token ${YOUR_CLUSTER_WORKER_TOKEN} \
  --discovery-token-ca-cert-hash ${YOUR_SHA_CERT}
```

Once you have access to `kubectl` and API access to your cluster; you need to use a network addon CNI, in this case we will use calico.
```
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.2/manifests/calico.yaml
```

That should make your nodes ready to run workloads.

## Pre-requisites
- `sudo apt-get install sshpass` *Or the `sshpass` package is required in your system to be able to run ssh commands with a plain-text password.

```
cd alma-k8s
ansible all -m ping -v --extra-vars "cluster_ssh_key=$SSH_KEY"
```

## Running playbook
This could be the first run since you dont have nopassword in visudo the first time you create the cluster.
```
ansible-playbook site.yml --extra-vars "cluster_ssh_key=$SSH_KEY ansible_sudo_pass=$CLUSTER_PASSWORD"
```
After having run the second time you may only use
```
ansible-playbook site.yml --extra-vars "cluster_ssh_key=$SSH_KEY"
```

### Argo CD installation

```
export ARGOCD_VERSION=<desired argo cd release version (e.g. v2.7.0)>
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/$ARGOCD_VERSION/manifests/install.yaml
```


## act locally Optional running with rancher desktop

Create your `.secrets` file with content:
```
proxmox_token_secret=YourProxmoxSecretToken   # Refer to proxmox provider documentantion
proxmox_token_id=YourProxmoxIDTerraform       # Refer to proxmox provider documentantion
cluster_password=YourPassword                 # < Admin user for the VMS
aws_access_key=AWSKeyId                       # Get it from AWS
aws_secret_key=AWSSecret                      # Get it from AWS
```

```
export DOCKER_HOST=unix://$HOME/.rd/docker.sock
export tfvars=/Users/angel.castrobasurto/Projects/almalinux_k8s_cluster/terraform/clusters/proxmox/env/homelab/terraform.tfvars
act --secret-file=.secrets --env TFVARS=${tfvars} --artifact-server-path /tmp/artifacts
```
