terraform {
  required_version = ">= 0.12"
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.10"
    }
  }
  backend "s3" {
    bucket = "terraform"
    key = "k8S.tfstate"

    region = "main"
    skip_credentials_validation = true
    skip_metadata_api_check = true
    skip_region_validation = true
    force_path_style = true
  }
}

# VM QEMU
# https://registry.terraform.io/providers/Telmate/proxmox/latest/docs/resources/vm_qemu
resource "proxmox_vm_qemu" "k8s_master" {
  count = 1
  vmid        = "110${count.index + 1}"
  name        = "k8s-master-10${count.index + 1}"
  target_node = var.target_node

  clone = var.template

  agent    = 1
  os_type  = "cloud-init"
  cores    = 2
  sockets  = 2
  cpu      = "host"
  memory   = 4096
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  ciuser = "k8s"

  disk {
    size         = "25G"
    type         = "scsi"
    storage      = "local-zfs"
  }

  network {
    model  = "virtio"
    bridge = "vmbr020"
  }

  lifecycle {
    ignore_changes = [
      network
    ]
  }

  ipconfig0 =  "ip=10.20.0.10${count.index + 1}/24,gw=10.20.0.254"

  sshkeys = <<EOF
  ${var.vm_ssh_authorized_key}
  EOF
}


resource "proxmox_vm_qemu" "k8s_worker" {
  count = 2
  vmid        = "111${count.index + 1}"
  name        = "k8s-worker-11${count.index + 1}"
  target_node = var.target_node

  clone = var.template

  agent    = 1
  os_type  = "cloud-init"
  cores    = 2
  sockets  = 2
  cpu      = "host"
  memory   = 4096
  scsihw   = "virtio-scsi-pci"
  bootdisk = "scsi0"

  ciuser = "k8s"

  disk {
    size         = "25G"
    type         = "scsi"
    storage      = "local-zfs"
  }

  network {
    model  = "virtio"
    bridge = "vmbr020"
  }

  lifecycle {
    ignore_changes = [
      network
    ]
  }

  ipconfig0 =  "ip=10.20.0.11${count.index + 1}/24,gw=10.20.0.254"

  sshkeys = <<EOF
  ${var.vm_ssh_authorized_key}
  EOF
}

resource "local_file" "AnsibleInventory" {
  filename = "${path.module}/../ansible/inventory"
  file_permission = "0644"
  content = templatefile("ansible-inventory.tftpl",
  {
    masters = proxmox_vm_qemu.k8s_master.*
    workers = proxmox_vm_qemu.k8s_worker.*
  }
  )
}
