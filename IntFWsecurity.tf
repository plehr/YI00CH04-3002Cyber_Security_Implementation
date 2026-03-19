resource "panos_security_policy" "int_ruleset" {
  provider = panos.int
  location = { vsys = { name = "vsys1" } }

  rules = [
    {
      name                  = "Staff-to-Proxy"
      rule_type             = "universal"
      source_zones          = ["Store Staff"]
      source_addresses      = ["10.10.0.0/24"]
      source_users          = ["any"]
      destination_zones     = ["Internal SRVs"]
      destination_addresses = ["10.0.100.70"]
      applications          = ["any"]
      services              = ["any"]
      category              = ["any"]
      action                = "allow"
    },
    {
      name                  = "DEVOPS-to-Proxy"
      rule_type             = "universal"
      source_zones          = ["DEVOPS"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["Internal SRVs"]
      destination_addresses = ["10.0.100.70"]
      applications          = ["any"]
      services              = ["http-proxy"]
      category              = ["any"]
      action                = "allow"
      source_hip            = ["any"]
      destination_hip       = ["any"]
    },
    {
      name                  = "Staff-to-DC"
      rule_type             = "universal"
      source_zones          = ["Store Staff"]
      source_addresses      = ["10.10.0.0/24"]
      source_users          = ["any"]
      destination_zones     = ["Internal SRVs"]
      destination_addresses = ["10.0.100.10"]
      applications          = [
        "active-directory",
        "kerberos",
        "ldap",
        "ms-ds-smb",
        "ms-netlogon",
        "msrpc",
        "netbios-dg",
        "netbios-ns",
        "netbios-ss",
        "ntp"
      ]
      services              = ["any"]
      category              = ["any"]
      action                = "allow"
      source_hip            = ["any"]
      destination_hip       = ["any"]
    },
    {
      name                  = "Staff-to-DC-DNS"
      rule_type             = "universal"
      source_zones          = ["Store Staff"]
      source_addresses      = ["10.10.0.0/24"]
      source_users          = ["any"]
      destination_zones     = ["Internal SRVs"]
      destination_addresses = ["10.0.100.10"]
      applications          = ["dns"]
      services              = ["application-default"]
      category              = ["any"]
      action                = "allow"
      source_hip            = ["any"]
      destination_hip       = ["any"]
      log_setting           = "forward-to-siem"
    },
    {
      name                  = "Allow-dns-to-dc"
      rule_type             = "universal"
      source_zones          = ["DEVOPS", "FW-Ext", "IT MGMT", "Internal SRVs", "MGMT-WS", "Store Staff"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["Internal SRVs"]
      destination_addresses = ["10.0.100.10"]
      applications          = ["dns", "dns-base"]
      services              = ["application-default"]
      category              = ["any"]
      action                = "allow"
      source_hip            = ["any"]
      destination_hip       = ["any"]
    },
    {
      name                  = "allow-dc-dns-to-fw-ext"
      rule_type             = "universal"
      source_zones          = ["Internal SRVs"]
      source_addresses      = ["10.0.100.10"]
      source_users          = ["any"]
      destination_zones     = ["FW-Ext"]
      destination_addresses = ["any"]
      applications          = ["dns", "dns-base"]
      services              = ["any"]
      category              = ["any"]
      action                = "allow"
      source_hip            = ["any"]
      destination_hip       = ["any"]
    },
    {
      name                  = "Staff-to-Intra-HTTPS"
      rule_type             = "universal"
      source_zones          = ["Store Staff"]
      source_addresses      = ["10.10.0.0/24"]
      source_users          = ["any"]
      destination_zones     = ["Internal SRVs"]
      destination_addresses = ["10.0.100.30"]
      applications          = ["ssl", "web-browsing"]
      services              = ["application-default"]
      category              = ["any"]
      action                = "allow"
    },
    {
      name                  = "Staff-to-Files-SMB"
      rule_type             = "universal"
      source_zones          = ["Store Staff"]
      source_addresses      = ["10.10.0.0/24"]
      source_users          = ["any"]
      destination_zones     = ["Internal SRVs"]
      destination_addresses = ["10.0.100.20"]
      applications          = ["ms-ds-smb"]
      services              = ["application-default"]
      category              = ["any"]
      action                = "allow"
    },
    {
      name                  = "MGMT-to-Fileserver"
      rule_type             = "universal"
      source_zones          = ["IT MGMT"]
      source_addresses      = ["10.100.0.0/24"]
      source_users          = ["any"]
      destination_zones     = ["Internal SRVs"]
      destination_addresses = ["10.0.100.20"]
      applications          = ["any"]
      services              = ["SMB"]
      category              = ["any"]
      action                = "allow"
      source_hip            = ["any"]
      destination_hip       = ["any"]
    },
    {
      name                  = "Staff-to-HR-HTTPS"
      rule_type             = "universal"
      source_zones          = ["Store Staff"]
      source_addresses      = ["10.10.0.0/24"]
      destination_zones     = ["FW-Ext"]
      destination_addresses = ["172.20.0.10"]
      applications          = ["ssl", "web-browsing"]
      services              = ["application-default"]
      action                = "allow"
    },
    {
      name                  = "MGMT-ws-to-all"
      rule_type             = "universal"
      source_zones          = ["MGMT-WS"]
      source_addresses      = ["10.100.0.0/24"]
      source_users          = ["any"]
      destination_zones     = ["any"]
      destination_addresses = ["any"]
      applications          = ["httport", "ms-rdp", "ntp", "ssh", "ssl", "web-browsing"]
      services              = ["application-default"]
      category              = ["any"]
      action                = "allow"
      source_hip            = ["any"]
      destination_hip       = ["any"]
    },
    {
      name                  = "PRTG-to-Infra"
      rule_type             = "universal"
      source_zones          = ["DEVOPS", "IT MGMT"]
      source_addresses      = ["10.99.0.40", "Dev-WS2"]
      source_users          = ["any"]
      destination_zones     = ["any"]
      destination_addresses = ["any"]
      applications          = [
        "active-directory-base",
        "dns-base",
        "dns-over-https",
        "github",
        "kerberos",
        "ldap",
        "ms-ds-smb",
        "ms-netlogon",
        "ms-wmi",
        "msrpc-base",
        "ntp",
        "ping",
        "smtp-base",
        "snmp",
        "ssh",
        "ssl"
      ]
      services              = ["application-default"]
      category              = ["any"]
      action                = "allow"
      source_hip            = ["any"]
      destination_hip       = ["any"]
    },
    {
      name                  = "All-Infra-to-SIEM"
      rule_type             = "universal"
      source_zones          = ["any"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["IT MGMT"]
      destination_addresses = ["10.99.0.10", "10.99.0.11", "10.99.0.12", "10.99.0.13"]
      applications          = ["syslog"]
      services              = ["any"]
      category              = ["any"]
      action                = "allow"
      log_end               = true
    },
    {
      name                  = "Kali-Terraform-Deploy-to-ALL"
      rule_type             = "universal"
      source_zones          = ["IT MGMT"]
      source_addresses      = ["10.100.0.107"]
      source_users          = ["any"]
      destination_zones     = ["any"]
      destination_addresses = ["any"]
      applications          = ["any"]
      services              = ["any"]
      category              = ["any"]
      action                = "allow"
      log_end               = true
      source_hip            = ["any"]
      destination_hip       = ["any"]
    },
    {
      name                  = "Allow-OOB-MGMT"
      rule_type             = "universal"
      source_zones          = ["OoB-mgmt"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["OoB-mgmt"]
      destination_addresses = ["any"]
      applications          = ["any"]
      services              = ["any"]
      category              = ["any"]
      action                = "allow"
      source_hip            = ["any"]
      destination_hip       = ["any"]
    },
    {
      name                  = "Intra-to-MySQL"
      rule_type             = "universal"
      source_zones          = ["Internal SRVs"]
      source_addresses      = ["10.0.100.30"]
      source_users          = ["any"]
      destination_zones     = ["Internal SRVs"]
      destination_addresses = ["10.0.100.50"]
      applications          = ["mysql"]
      services              = ["application-default"]
      category              = ["any"]
      action                = "allow"
    },
    {
      name                  = "Extranet-to-MySQL"
      rule_type             = "universal"
      source_zones          = ["FW-Ext"]
      source_addresses      = ["10.10.10.10"]
      source_users          = ["any"]
      destination_zones     = ["Internal SRVs"]
      destination_addresses = ["10.0.100.50"]
      applications          = ["mysql"]
      services              = ["application-default"]
      category              = ["any"]
      action                = "allow"
    },
    {
      name                  = "Magento-to-MySQL"
      rule_type             = "universal"
      source_zones          = ["FW-Ext"]
      source_addresses      = ["10.10.10.20"]
      source_users          = ["any"]
      destination_zones     = ["Internal SRVs"]
      destination_addresses = ["10.0.100.50"]
      applications          = ["mysql"]
      services              = ["application-default"]
      category              = ["any"]
      action                = "allow"
    },
    {
      name                  = "ns1-ns2-DNS"
      rule_type             = "universal"
      source_zones          = ["FW-Ext"]
      source_addresses      = ["10.10.10.4", "10.10.10.8"]
      source_users          = ["any"]
      destination_zones     = ["FW-Ext"]
      destination_addresses = ["10.10.10.4", "10.10.10.8"]
      applications          = ["dns"]
      services              = ["application-default"]
      category              = ["any"]
      action                = "allow"
    },
    {
      name                  = "DC-to-ns1ns2-DNS"
      rule_type             = "universal"
      source_zones          = ["Internal SRVs"]
      source_addresses      = ["10.0.100.10"]
      source_users          = ["any"]
      destination_zones     = ["FW-Ext"]
      destination_addresses = ["10.10.10.4", "10.10.10.8", "198.18.100.4", "198.18.100.8"]
      applications          = ["dns"]
      services              = ["application-default"]
      category              = ["any"]
      action                = "allow"
    },
    {
      name                  = "Internal-to-NTP"
      rule_type             = "universal"
      source_zones          = ["any"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["FW-Ext"]
      destination_addresses = ["10.10.10.2"]
      applications          = ["ntp"]
      services              = ["application-default"]
      category              = ["any"]
      action                = "allow"
    },
    {
      name                  = "DevOps-to-GitLab"
      rule_type             = "universal"
      source_zones          = ["DEVOPS"]
      source_addresses      = ["10.0.110.10", "10.0.110.20"]
      source_users          = ["any"]
      destination_zones     = ["DEVOPS"]
      destination_addresses = ["10.0.110.100"]
      applications          = ["ssh", "ssl"]
      services              = ["application-default"]
      category              = ["any"]
      action                = "allow"
    },
    {
      name                  = "Proxy-Internet-Access"
      rule_type             = "universal"
      source_zones          = ["Internal SRVs"]
      source_addresses      = ["10.0.100.70"]
      destination_zones     = ["FW-Ext"]
      destination_addresses = ["any"]
      applications          = ["any"]
      services              = ["application-default"]
      action                = "allow"
    },
    {
      name                  = "Allow-Internet"
      rule_type             = "universal"
      source_zones          = ["DEVOPS", "Internal SRVs", "IT MGMT", "MGMT-WS", "OoB-mgmt", "Store Staff"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["FW-Ext"]
      destination_addresses = ["any"]
      applications          = ["httport", "ssl", "web-browsing"]
      services              = ["service-http", "service-https"]
      category              = ["any"]
      action                = "allow"
      source_hip            = ["any"]
      destination_hip       = ["any"]
    },
    {
      name                  = "Allow-to-Fireeye-application"
      rule_type             = "universal"
      source_zones          = ["any"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["IT MGMT"]
      destination_addresses = ["10.99.0.30"]
      applications          = ["web-browsing"]
      services              = ["application-default"]
      category              = ["any"]
      action                = "allow"
      source_hip            = ["any"]
      destination_hip       = ["any"]
    },
    {
      name                  = "Allow-to-Fireeye"
      rule_type             = "universal"
      source_zones          = ["any"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["IT MGMT"]
      destination_addresses = ["10.99.0.30"]
      applications          = ["any"]
      services              = ["service-http", "service-https"]
      category              = ["any"]
      action                = "allow"
      source_hip            = ["any"]
      destination_hip       = ["any"]
    },
    {
      name                  = "Allow-Mgmt-to-all-mgmt"
      rule_type             = "universal"
      source_zones          = ["OoB-mgmt"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["DEVOPS", "IT MGMT", "Internal SRVs", "MGMT-WS", "OoB-mgmt", "Store Staff"]
      destination_addresses = ["any"]
      applications          = ["httport", "ms-rdp", "ssh", "ssl"]
      services              = ["RDP", "SSH", "service-http", "service-https"]
      category              = ["any"]
      action                = "allow"
      log_setting           = "lokille"
      source_hip            = ["any"]
      destination_hip       = ["any"]
    },
    {
      name                  = "Allow-mgmt-to-all"
      rule_type             = "universal"
      source_zones          = ["IT MGMT", "OoB-mgmt"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["any"]
      destination_addresses = ["any"]
      applications          = ["any"]
      services              = ["any"]
      category              = ["any"]
      action                = "allow"
      source_hip            = ["any"]
      destination_hip       = ["any"]
    },
    {
      name                  = "allow-traffic"
      rule_type             = "universal"
      source_zones          = ["Internal SRVs"]
      source_addresses      = ["10.0.100.0/24"]
      source_users          = ["any"]
      destination_zones     = ["Internal SRVs"]
      destination_addresses = ["10.0.100.10"]
      applications          = ["any"]
      services              = ["application-default"]
      category              = ["any"]
      action                = "allow"
      source_hip            = ["any"]
      destination_hip       = ["any"]
      log_setting           = "forward-to-siem"
    },
    {
      name                  = "Allow-log-collection"
      rule_type             = "universal"
      source_zones          = ["DEVOPS", "FW-Ext", "Internal SRVs"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["any"]
      destination_addresses = ["any"]
      applications          = ["any"]
      services              = ["elasticsearch"]
      category              = ["any"]
      action                = "allow"
      description           = "This policy is to allow log collection to happen over port 9200"
      tag                   = ["logs", "elasticsearch"]
      source_hip            = ["any"]
      destination_hip       = ["any"]
    },
    {
      name                  = "Allow everything to SIEM"
      rule_type             = "universal"
      source_zones          = ["any"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["any"]
      destination_addresses = ["10.99.0.10"]
      applications          = ["any"]
      services              = ["any"]
      category              = ["any"]
      action                = "allow"
      tag                   = ["logs"]
      source_hip            = ["any"]
      destination_hip       = ["any"]
    },
    {
      name                  = "Allow-LDAP-to-DC"
      rule_type             = "universal"
      source_zones          = ["FW-Ext"]
      source_addresses      = ["10.10.10.0/24"]
      source_users          = ["any"]
      destination_zones     = ["Internal SRVs"]
      destination_addresses = ["10.0.100.10"]
      applications          = ["any"]
      services              = ["LDAP"]
      category              = ["any"]
      action                = "allow"
      log_end               = true
      disabled              = false
      source_hip            = ["any"]
      destination_hip       = ["any"]
    },
    {
      name                  = "Allow SSH to DEV-WS2"
      rule_type             = "universal"
      source_zones          = ["Internal SRVs", "IT MGMT"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["DEVOPS"]
      destination_addresses = ["10.0.110.20"]
      applications          = ["any"]
      services              = ["SSH"]
      category              = ["any"]
      action                = "allow"
      source_hip            = ["any"]
      destination_hip       = ["any"]
    },
    {
      name                  = "Allow-custom-security-scanner-to-all"
      rule_type             = "universal"
      source_zones          = ["DEVOPS"]
      source_addresses      = ["10.0.110.20"]
      source_users          = ["any"]
      destination_zones     = ["any"]
      destination_addresses = ["any"]
      applications          = ["any"]
      services              = ["application-default"]
      category              = ["any"]
      action                = "allow"
      source_hip            = ["any"]
      destination_hip       = ["any"]
    },
    {
      name                  = "Staff-to-FWExt-Deny"
      rule_type             = "universal"
      description           = "Deny Staff to DMZ (arrives via FW-Ext zone on fw-int)"
      source_zones          = ["Store Staff"]
      source_addresses      = ["10.10.0.0/24"]
      source_users          = ["any"]
      destination_zones     = ["FW-Ext"]
      destination_addresses = ["any"]
      applications          = ["any"]
      services              = ["any"]
      category              = ["any"]
      action                = "deny"
      log_end               = true
      disabled              = false
    },
    {
      name                  = "Deny-MySQL-Cleanup"
      rule_type             = "universal"
      source_zones          = ["any"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["any"]
      destination_addresses = ["10.0.100.50"]
      applications          = ["mysql"]
      services              = ["any"]
      category              = ["any"]
      action                = "deny"
      log_end               = true
      disabled              = false
    },
    {
      name                  = "Deny-Clients-DNS-Recursion"
      rule_type             = "universal"
      source_zones          = ["any"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["FW-Ext"]
      destination_addresses = ["10.10.10.4", "10.10.10.8"]
      applications          = ["dns"]
      services              = ["application-default"]
      category              = ["any"]
      action                = "deny"
      log_end               = true
      disabled              = false
    },
    {
      name                  = "Deny-Internet-NTP"
      rule_type             = "universal"
      source_zones          = ["any"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["FW-Ext"]
      destination_addresses = ["any"]
      applications          = ["ntp"]
      services              = ["application-default"]
      category              = ["any"]
      action                = "deny"
      log_end               = true
      disabled              = false
    },
    {
      name                  = "Deny-DevOps-SRV-FWExt"
      rule_type             = "universal"
      source_zones          = ["DEVOPS"]
      source_addresses      = ["10.0.110.10"]
      source_users          = ["any"]
      destination_zones     = ["FW-Ext", "Internal SRVs"]
      destination_addresses = ["any"]
      applications          = ["any"]
      services              = ["any"]
      category              = ["any"]
      action                = "deny"
      log_end               = true
      source_hip            = ["any"]
      destination_hip       = ["any"]
      disabled              = false
    },
    {
      name                  = "Global-Cleanup-Deny"
      rule_type             = "universal"
      source_zones          = ["any"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["any"]
      destination_addresses = ["any"]
      applications          = ["any"]
      services              = ["any"]
      category              = ["any"]
      action                = "deny"
      log_end               = true
      source_hip            = ["any"]
      destination_hip       = ["any"]
      disabled              = false
    }
  ]
}