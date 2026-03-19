### Internal Firewall ### 
variable "int_hostname" {
  type        = string
  description = "internal firewall hostname"
}

variable "int_user" {
  type        = string
  description = "internal firewall username"
}

variable "int_password" {
  type        = string
  description = "internal firewall password"
  sensitive = true
}

### External Firewall ###
variable "ext_hostname" {
  type        = string
  description = "external firewall hostname"
}

variable "ext_user" {
  type        = string
  description = "external firewall username"
}

variable "ext_password" {
  type        = string
  description = "external firewall password"
  sensitive = true
}