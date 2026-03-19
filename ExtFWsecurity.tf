resource "panos_security_policy" "ext_ruleset" {
  provider = panos.ext
  location = { vsys = { name = "vsys1" } }

  rules = [
    # IN-Extranet-HTTPS
    {
      name                  = "IN-Extranet-HTTPS"
      source_zones          = ["INET"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["DMZ"]
      destination_addresses = ["198.19.2.10"]
      applications          = ["ssl", "web-browsing"]
      services              = ["application-default"]
      category              = ["any"]
      rule_type             = "universal"
      action                = "allow"
    },
    # IN-WWW-HTTPS
    {
      name                  = "IN-WWW-HTTPS"
      source_zones          = ["INET"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["DMZ"]
      destination_addresses = ["198.19.2.20"]
      applications          = ["ssl", "web-browsing"]
      services              = ["application-default"]
      category              = ["any"]
      rule_type             = "universal"
      action                = "allow"
    },
    # IN-Helpdesk-HTTPS
    {
      name                  = "IN-Helpdesk-HTTPS"
      source_zones          = ["INET"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["DMZ"]
      destination_addresses = ["198.19.2.40"]
      applications          = ["ssl", "web-browsing"]
      services              = ["application-default"]
      category              = ["any"]
      rule_type             = "universal"
      action                = "allow"
    },

    # Allow-dns-queries-intern
    {
      name                  = "Allow-dns-queries-intern"
      source_zones          = ["FW-Int"]
      source_addresses      = ["10.0.100.10"]
      source_users          = ["any"]
      destination_zones     = ["INET"]
      destination_addresses = ["any"]
      applications          = ["any"]
      services              = ["dns-tcp-53", "dns-udp-53"]
      category              = ["any"]
      source_hip            = ["any"]
      destination_hip       = ["any"]
      rule_type             = "universal"
      action                = "allow"
    },
    # Allow-dns-queries-DMZ
    {
      name                  = "Allow-dns-queries-DMZ"
      source_zones          = ["DMZ"]
      source_addresses      = ["10.10.10.4", "10.10.10.8"]
      source_users          = ["any"]
      destination_zones     = ["INET"]
      destination_addresses = ["any"]
      applications          = ["dns", "dns-base"]
      services              = ["application-default"]
      category              = ["any"]
      source_hip            = ["any"]
      destination_hip       = ["any"]
      rule_type             = "universal"
      action                = "allow"
    },
    # Allow-dns-to-dc
    {
      name                  = "Allow-dns-to-dc"
      source_zones          = ["Business SRVs", "DMZ", "OoB-mgmt"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["FW-Int"]
      destination_addresses = ["10.0.100.10"]
      applications          = ["dns", "dns-base"]
      services              = ["any"]
      category              = ["any"]
      source_hip            = ["any"]
      destination_hip       = ["any"]
      rule_type             = "universal"
      action                = "allow"
    },
    # IN-ns1-DNS
    {
      name                  = "IN-ns1-DNS"
      source_zones          = ["INET"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["DMZ"]
      destination_addresses = ["198.19.2.4"]
      applications          = ["dns"]
      services              = ["application-default"]
      category              = ["any"]
      rule_type             = "universal"
      action                = "allow"
    },
    # IN-ns2-DNS
    {
      name                  = "IN-ns2-DNS"
      source_zones          = ["INET"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["DMZ"]
      destination_addresses = ["198.19.2.8"]
      applications          = ["dns"]
      services              = ["application-default"]
      category              = ["any"]
      rule_type             = "universal"
      action                = "allow"
    },
    # IN-MailMX-SMTP
    {
      name                  = "IN-MailMX-SMTP"
      source_zones          = ["INET"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["DMZ"]
      destination_addresses = ["198.19.2.30"]
      applications          = ["smtp"]
      services              = ["application-default"]
      category              = ["any"]
      rule_type             = "universal"
      action                = "allow"
    },
    # Staff-to-HR-HTTPS
    {
      name                  = "Staff-to-HR-HTTPS"
      source_zones          = ["FW-Int"]
      source_addresses      = ["10.10.0.0/24"]
      source_users          = ["any"]
      destination_zones     = ["Business SRVs"]
      destination_addresses = ["172.20.0.10"]
      applications          = ["ssl", "web-browsing"]
      services              = ["application-default"]
      category              = ["any"]
      rule_type             = "universal"
      action                = "allow"
    },

    # DMZ-EGRESS-HTTPS
    {
      name                  = "DMZ-EGRESS-HTTPS"
      source_zones          = ["DMZ"]
      source_addresses      = ["10.10.10.10", "10.10.10.20", "10.10.10.40"]
      source_users          = ["any"]
      destination_zones     = ["INET"]
      destination_addresses = ["any"]
      applications          = ["ssl", "web-browsing"]
      services              = ["application-default"]
      category              = ["any"]
      rule_type             = "universal"
      action                = "allow"
    },
    # DMZ-Mail-EGRESS-SMTP
    {
      name                  = "DMZ-Mail-EGRESS-SMTP"
      source_zones          = ["DMZ"]
      source_addresses      = ["10.10.10.30"]
      source_users          = ["any"]
      destination_zones     = ["INET"]
      destination_addresses = ["any"]
      applications          = ["smtp"]
      services              = ["application-default"]
      category              = ["any"]
      rule_type             = "universal"
      action                = "allow"
    },
    # DMZ-to-DC
    {
      name                  = "DMZ-to-DC"
      source_zones          = ["DMZ"]
      source_addresses      = ["10.10.10.30", "10.10.10.40"]
      source_users          = ["any"]
      destination_zones     = ["FW-Int"]
      destination_addresses = ["10.0.100.10"]
      applications          = ["ldap"]
      services              = ["application-default"]
      category              = ["any"]
      source_hip            = ["any"]
      destination_hip       = ["any"]
      rule_type             = "universal"
      action                = "allow"
    },
    # DMZ-DNS-EGRESS
    {
      name                  = "DMZ-DNS-EGRESS"
      source_zones          = ["DMZ"]
      source_addresses      = ["10.10.10.4", "10.10.10.8"]
      source_users          = ["any"]
      destination_zones     = ["INET"]
      destination_addresses = ["any"]
      applications          = ["dns", "dns-base"]
      services              = ["any"]
      category              = ["any"]
      source_hip            = ["any"]
      destination_hip       = ["any"]
      rule_type             = "universal"
      action                = "allow"
    },
    # DMZ-SERVICES
    {
      name                  = "DMZ-SERVICES"
      source_zones          = ["any"]
      source_addresses      = ["Dev-WS2"]
      source_users          = ["any"]
      destination_zones     = ["DMZ", "INET"]
      destination_addresses = ["any"]
      applications          = ["any"]
      services              = ["application-default"]
      category              = ["any"]
      source_hip            = ["any"]
      destination_hip       = ["any"]
      rule_type             = "universal"
      action                = "allow"
    },
    # Allow-OOB-mgmt
    {
      name                  = "Allow-OOB-mgmt"
      source_zones          = ["OoB-mgmt"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["OoB-mgmt"]
      destination_addresses = ["any"]
      applications          = ["any"]
      services              = ["any"]
      category              = ["any"]
      source_hip            = ["any"]
      destination_hip       = ["any"]
      rule_type             = "universal"
      action                = "allow"
    },
    # PRTG allow monitoring
    {
      name                  = "PRTG allow monitoring"
      source_zones          = ["FW-Int"]
      source_addresses      = ["10.99.0.40"]
      source_users          = ["any"]
      destination_zones     = ["Business SRVs", "DMZ"]
      destination_addresses = ["any"]
      applications          = ["ping"]
      services              = ["application-default"]
      category              = ["any"]
      source_hip            = ["any"]
      destination_hip       = ["any"]
      rule_type             = "universal"
      action                = "allow"
    },
    # Allow-SSL-to-Fireeye
    {
      name                  = "Allow-SSL-to-Fireeye"
      source_zones          = ["Business SRVs", "DMZ"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["FW-Int"]
      destination_addresses = ["10.99.0.30"]
      applications          = ["any"]
      services              = ["service-http", "service-https"]
      category              = ["any"]
      source_hip            = ["any"]
      destination_hip       = ["any"]
      rule_type             = "universal"
      action                = "allow"
    },
    # Allow-PRTG
    {
      name                  = "Allow-PRTG"
      source_zones          = ["FW-Int"]
      source_addresses      = ["10.99.0.40"]
      source_users          = ["any"]
      destination_zones     = ["Business SRVs", "DMZ"]
      destination_addresses = ["any"]
      applications          = ["any"]
      services              = ["DNC_TCP", "DNS_UDP", "SMTP_TCP", "SNMP_UDP"]
      category              = ["any"]
      source_hip            = ["any"]
      destination_hip       = ["any"]
      rule_type             = "universal"
      action                = "allow"
    },
    # Allow-OOB-any
    {
      name                  = "Allow-OOB-any"
      source_zones          = ["FW-Int", "OoB-mgmt"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["any"]
      destination_addresses = ["any"]
      applications          = ["any"]
      services              = ["any"]
      category              = ["any"]
      source_hip            = ["any"]
      destination_hip       = ["any"]
      rule_type             = "universal"
      action                = "allow"
    },
    # Allow-log-collection
   {
  name                  = "Allow-log-collection"
  source_zones          = ["any"]
  source_addresses      = ["any"]
  source_users          = ["any"]
  destination_zones     = ["FW-Int"]
  destination_addresses = ["any"]
  applications          = ["any"]
  services              = ["elasticsearch"]
  category              = ["any"]
  source_hip            = ["any"]
  destination_hip       = ["any"]
  rule_type             = "universal"
  action                = "allow"
  tags                  = ["logs", "elasticsearch"]
  description           = "This policy is to allow log collection to happen over port 9200"
},
    # Allow everything to SIEM
    {
  name                  = "Allow everything to SIEM"
  source_zones          = ["any"]
  source_addresses      = ["any"]
  source_users          = ["any"]
  destination_zones     = ["any"]
  destination_addresses = ["10.99.0.10"]
  applications          = ["any"]
  services              = ["any"]
  category              = ["any"]
  source_hip            = ["any"]
  destination_hip       = ["any"]
  rule_type             = "universal"
  action                = "allow"
  tags                  = ["logs"]
},
    # Proxy-to-Internet
    {
      name                  = "Proxy-to-Internet"
      source_zones          = ["FW-Int"]
      source_addresses      = ["10.0.100.70"]
      destination_zones     = ["INET"]
      destination_addresses = ["any"]
      applications          = ["ssl", "web-browsing"]
      services              = ["application-default"]
      rule_type             = "universal"
      action                = "allow"
      description           = "Proxy node outbound HTTP/HTTPS to internet"
    },
    # Allow-NTP
    {
      name                  = "Allow-NTP"
      source_zones          = ["Business SRVs", "FW-Int"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["DMZ"]
      destination_addresses = ["any"]
      applications          = ["any"]
      services              = ["ntp-udp-123"]
      category              = ["any"]
      source_hip            = ["any"]
      destination_hip       = ["any"]
      action                = "allow"
    },
    # Allow-NTP-to-Internet
    {
      name                  = "Allow-NTP-to-Internet"
      source_zones          = ["DMZ"]
      source_addresses      = ["10.10.10.2"]
      source_users          = ["any"]
      destination_zones     = ["INET"]
      destination_addresses = ["any"]
      applications          = ["any"]
      services              = ["ntp-udp-123"]
      category              = ["any"]
      source_hip            = ["any"]
      destination_hip       = ["any"]
      action                = "allow"
    },

    # Deny rules (with disabled = false and log_end = true)
    {
      name                  = "DENY-WWW-HTTP-80"
      source_zones          = ["INET"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["DMZ"]
      destination_addresses = ["198.19.2.20"]
      applications          = ["web-browsing"]
      services              = ["application-default"]
      category              = ["any"]
      rule_type             = "universal"
      action                = "deny"
      log_end               = true
      disabled              = false
    },
    {
      name                  = "DENY-DMZ-Admin-Paths"
      source_zones          = ["INET"]
      source_addresses      = ["any"]
      source_users          = ["any"]
      destination_zones     = ["DMZ"]
      destination_addresses = ["198.19.2.0/24"]
      applications          = ["any"]
      services              = ["any"]
      category              = ["any"]
      rule_type             = "universal"
      action                = "deny"
      log_end               = true
      disabled              = false
      description           = "Block admin paths; attach URL filtering profile for /admin /wp-login.php"
    },
{
  name                  = "DMZ-EGRESS-DENY-ALL"
  source_zones          = ["DMZ"]
  source_addresses      = ["any"]
  source_users          = ["any"]
  destination_zones     = ["INET"]
  destination_addresses = ["any"]
  applications          = ["any"]
  services              = ["any"]
  category              = ["any"]
  rule_type             = "universal"
  action                = "deny"
  log_end               = true
  disabled              = false
},
    {
  name                  = "Global-Cleanup-Deny"
  source_zones          = ["any"]
  source_addresses      = ["any"]
  source_users          = ["any"]
  destination_zones     = ["any"]
  destination_addresses = ["any"]
  applications          = ["any"]
  services              = ["any"]
  category              = ["any"]
  source_hip            = ["any"]
  destination_hip       = ["any"]
  rule_type             = "universal"
  action                = "deny"
  log_end               = true
  disabled              = false
}
  ]
}
