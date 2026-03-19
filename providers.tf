terraform {
  required_providers {
    panos = {
      source = "PaloAltoNetworks/panos"
      version = "2.0.0"
    }
  }
}

provider "panos" {
  alias                = "int"
  hostname             = var.int_hostname
  username             = var.int_user
  password             = var.int_password
  skip_verify_certificate = true
}

provider "panos" {
  alias                = "ext"
  hostname             = var.ext_hostname
  username             = var.ext_user
  password             = var.ext_password
  skip_verify_certificate = true
}