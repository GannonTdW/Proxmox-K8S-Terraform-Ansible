# Proxmox K8S Terraform Ansible

*[Lire ce readme en français.](./README_fr.md)*

## Introduction

This depo is for create a Kubernetes cluster on a Proxmox server.
For this, is used:

- Direnv for work environment 
- Terraform to create VM
- Minio to store tfstate
- Ansible for automating the creation of the cluster
- Kubeadm to create the Kubernetes cluster.
- Calico for the network
- Metallb for having external ip on our own networks

Only Almalinux 8 is supported and tested.
There is a problem with the k8s and helm modules ( [ see this issue ] ( https://github.com/ansible-collections/kubernetes.core/issues/507) ), but a circumvention method was used.
The playbook should work with other RedHat family distributions.

There are problems with the gpg key of kubernetes apt repo [ see this issue ] ( https://github.com/kubernetes/release/issues/1982)

## Installation of the environment

To install the insensitive, terraform ( prerequisites,... ) execute the following command:

```
make env
```

With the MakeFile this will create a dedicated python vitualenv with all the python packages and install terraform in the `.direnv` folder.
Environmental variables will help configure the environment.
These will be automatically loaded as soon as the current directory is in the project tree.


More information [here](https://ansible-ultimate-edition.readthedocs.io/en/latest/exercises/basics/ex02-config.html) (fr).

## How to use

The project use terraform and ansible for create vms and configure the k8s cluster.
It will therefore be necessary to execute terraform to create the vms and then use ansible to configure the kubenetes cluster.¬

### Terraform

```
# Initialize Terraform
terraform -chdir=terraform init
# Create vms
terraform -chdir=terraform apply --auto-approve
# Destroy vms
terraform -chdir=terraform destroy --auto-approve

```

### Ansible

```
ansible-playbook -b ansible/k8s-proxmox.yml
```

## Sources et Inspirations

- [Direnv et installation d'Ansible et Terraform](https://ansible-ultimate-edition.readthedocs.io/en/latest/) (fr)
- [dy2k/proxmox-kubernetes](https://github.com/dy2k/proxmox-kubernetes)
- [kairen/kubeadm-ansible](https://github.com/kairen/kubeadm-ansible)
- [geerlingguy/ansible-role-helm](https://github.com/geerlingguy/ansible-role-helm)
