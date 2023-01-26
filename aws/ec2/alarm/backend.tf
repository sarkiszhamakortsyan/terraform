terraform {
  backend "remote" {
    organization = "EBVGZ"

    workspaces {
        name = "create-instance"
    }
  }
}