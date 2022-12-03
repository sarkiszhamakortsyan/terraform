# You can build several different kind of machines. 
# Every machine MUST be in different file
# First part is the emulator, and second file name
resource "proxmox_vm_qemu" "ubuntu_srv_01" {
  # Machine name
  name = "ubuntu-srv-01"
  # Distribution
  desc = "Linux"
  # VMID on Proxmox server. MUST be different on every machine
  vmid = "8001"
  # Name of the Proxmox. In my case is "pve"
  target_node = "pve"

  # Enable the QEMU agent to apply the settings like IP, and etc
  agent = 1

  # Name of the template in Proxmox
  clone = "ubuntu-cloud"
  # Number of CPUs
  cores = 1
  # Number of sockets
  sockets = 1
  # Which SPU
  cpu = "host"
  # Amount of RAM
  memory = 2048

  # Add network adapter
  network {
    bridge = "vmbr0"
    model  = "virtio"
  }

  # Add disk. You can change the size.
  disk {
    storage = "local-lvm"
    type    = "virtio"
    size    = "50G"
  }

  # Custom settings
  os_type    = "Linux"
  ipconfig0  = "ip=192.168.0.48/24,gw=192.168.0.1"
  nameserver = "192.168.0.1"
  ciuser     = "sako"
  sshkeys    = <<EOF
    ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8GWNNpwFzORJvYfzaZQ3zqd1w3WEQgMX7mx+kbX+Vaxo/9Kmji++KogUH9xyrxiA9TZEKPBCaFJI+0cJIqxzDyN8NF2x4ISUGyAmvQ49WrFnTtV7pQUd7UkbhLzqj7VFjWzcIlhsfLms25/Rjumbngnh9NWpu8CEZ2atYhJgPQ5+gibGomjwDsQ5CE4BEsk2NDPj7EwFqj5uwaUvr3UIYH1gjFTx2sck+PWpwsuXNT16jz6W1O9uEY8JHPIrA0DqDYYhj3PqSqgbiLL1cAYT0aZ4bWDCgma6rX9MDuIGvux5zdGHgR53u9kJMS+ifkOn3JO2DMCJj1bAEV9grhmPSgk40B7fKbMNALNpHKO1gbVeyMiqWaYFSDGwboXeaKn3IgpMGC5BDuc2/fYxI2nKQFQs8qVcCF3Eg+tGlOPJ7q+g0iHBEZIxW9rWg4oxgk+3IKpqXPrDfqqW78k5l2nFjZ3Y1neHYOoLIM1Do6+JYssl7BpUhAPnKHHk7xCD+pmk= sako@DESKTOP-VJ2NL5A
    EOF
}