terraform {
  required_providers {
    proxmox = {
      source = "Telmate/proxmox"
      version = "3.0.2-rc01"
    }
  }
}

provider "proxmox" {
 pm_api_url   = "https://192.168.21.9:8006/api2/json"
 pm_user      = "root@pam!terraform"
 pm_password  = "5cce2501-4a47-47cf-baac-b24128cc1ea6"
 pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "my_vm" {
  name        = "my-vm"
  target_node = "pve-node"
  clone       = "ubuntu-template"
  storage     = "local-lvm"
  cores       = 2
  memory      = 2048
  os_type     = "cloud-init"
  ipconfig0   = "ip=10.0.0.100/24,gw=10.0.0.1"
  sshkeys     = file("~/.ssh/id_rsa.pub")
}
