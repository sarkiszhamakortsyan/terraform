resource "proxmox_vm_qemu" "ubuntu_srv_02" {
  name        = "ubuntu-srv-02"
  desc        = "Linux"
  vmid        = "8002"
  target_node = "pve"

  agent = 1

  clone   = "ubuntu-cloud"
  cores   = 2
  sockets = 1
  memory  = 4096
  cpu     = "host"

  disk {
    storage = "local-lvm"
    size    = "30G"
    type    = "virtio"
  }

  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  os_type    = "Linux"
  ipconfig0  = "ip=192.168.0.47/24,gw=192.168.0.1"
  nameserver = "192.168.0.1"
  ciuser     = "sako"
  sshkeys    = <<EOF
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8GWNNpwFzORJvYfzaZQ3zqd1w3WEQgMX7mx+kbX+Vaxo/9Kmji++KogUH9xyrxiA9TZEKPBCaFJI+0cJIqxzDyN8NF2x4ISUGyAmvQ49WrFnTtV7pQUd7UkbhLzqj7VFjWzcIlhsfLms25/Rjumbngnh9NWpu8CEZ2atYhJgPQ5+gibGomjwDsQ5CE4BEsk2NDPj7EwFqj5uwaUvr3UIYH1gjFTx2sck+PWpwsuXNT16jz6W1O9uEY8JHPIrA0DqDYYhj3PqSqgbiLL1cAYT0aZ4bWDCgma6rX9MDuIGvux5zdGHgR53u9kJMS+ifkOn3JO2DMCJj1bAEV9grhmPSgk40B7fKbMNALNpHKO1gbVeyMiqWaYFSDGwboXeaKn3IgpMGC5BDuc2/fYxI2nKQFQs8qVcCF3Eg+tGlOPJ7q+g0iHBEZIxW9rWg4oxgk+3IKpqXPrDfqqW78k5l2nFjZ3Y1neHYOoLIM1Do6+JYssl7BpUhAPnKHHk7xCD+pmk= sako@DESKTOP-VJ2NL5A
    EOF
}