locals {
  vm_name        = "web"
  each_vm_config = { for vm in var.each_vm : vm.vm_name => vm }
  ssh_key        = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
}

