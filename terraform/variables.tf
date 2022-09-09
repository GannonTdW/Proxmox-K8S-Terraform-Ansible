# Variable Declaration
variable  "pm_api_url" {
    type        = string
    description = "Proxmox Api url"
}
variable  "pm_api_token_id" {
    type        = string
    description = "Proxmox api token id"
}
variable  "pm_api_token_secret" {
    type        = string
    description = "Proxmox api token secret"
}
variable  "target_node" {
    type        = string
    description = "Proxmox node name"
    default =  "pve"
}
variable "template" {
    type        = string
    description = "Proxmox template clone name"
    default = "AlmaLinux8" #  "debian-11"
}
variable  "vm_ssh_authorized_key" {
    type        = string
    description = "vm ssh/authorized_keys"
    default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMkwUbwGvJUG849v9R7PMbM3ORcg5Pn3BmiwdDVRNOFq thibaud@ArchBertha-2022-01-19\nssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIN7ZxEs36I9GidLyAbll+bWabzDEdYUtmgAO50w03NyG thibaud@archlog-2021-10-26"
}

