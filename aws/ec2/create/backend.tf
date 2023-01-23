terraform {
  backend "remote" {
    organization = "SakoLTD"

    workspaces {
        name = "cli-workspace"
    }
  }
}