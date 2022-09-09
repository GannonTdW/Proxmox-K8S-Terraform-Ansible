# Proxmox K8S Terraform Ansible

*[Read this readme in english.](./README.md)*

## Introduction

Ce depo à pour but de créer un cluster Kubernetes sur un serveur Proxmox.
Pour cela, est utilisé:

- Direnv pour l'envirnement de travaille
- Terraform pour créer les VMs
- Minio pour stocker les tfstate
- Ansible pour automatiser la création du cluster
- Kubeadm pour créer le cluster Kubernetes.
- Calico pour le réseau
- Metallb pour avoir des ip externes sur notre propre réseaux

Seulement Almalinux 8 est supporté et testé.
Il y a un problème avec les modules k8s et helm ([voir cette issue](https://github.com/ansible-collections/kubernetes.core/issues/507) ), mais une méthode de contournement a été utilisée.
Le playbook devrait fonctionner avec les autres distributions de la famille RedHat.

Il ya des problème avec la clef gpg des repo apt kubernetes [ voir cette issue](https://github.com/kubernetes/release/issues/1982)

## Installation de l'environnement

Pour installer les prérequis (ansible, terraform, ... ) exécuter la commande suivante:

```
make env
```

Cela va créer grâce au fichier Makefile, un vitualenv python dédié avec toutes les prérequis python requis et installer terraform dans le dossier `.direnv`.
Mais aussi configurer ansible et plus généralement l'environnement par les variables d'environnement.
Celles-ci seront chargées automatiquement par direnv dès que le répertoire courant sera dans l'arborécence du projet.

Pus d'information par [ici](https://ansible-ultimate-edition.readthedocs.io/en/latest/exercises/basics/ex02-config.html).

## Utilisation

Le projet utilise terraform et ansible pour créer et configurer les vms.
Il faudra donc executer les commandes terraform pour créer les vms puis executer les commandes ansible pour les configurer.

### Terraform

```
# Initialise l'environnement de travail Terraform
terraform -chdir=terraform init
# Créer les vms
terraform -chdir=terraform apply --auto-approve
# Détruit les vms
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
