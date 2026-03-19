# Cyber Security Implementation in Practice - Firewall Configuration

This project implements comprehensive firewall security policies using Terraform and the Palo Alto Networks (PAN-OS) provider for managing network security in a multi-zone environment.

## Course Information
- **Course**: YI00CH04-3002 - Cyber Security Implementation in Practice
- **Technology**: Palo Alto Networks Firewalls (PAN-OS)
- **Infrastructure as Code**: Terraform

## Architecture Overview

The configuration manages two firewall instances:

### External Firewall (EXT)
- **Hostname**: Configurable via `ext_hostname` variable
- **Purpose**: Internet-facing firewall managing inbound/outbound traffic

### Internal Firewall (INT)
- **Hostname**: Configurable via `int_hostname` variable
- **Purpose**: Internal network segmentation and security enforcement

## Network Zones

- **INET**: Internet zone
- **DMZ**: Demilitarized zone for public-facing services
- **FW-Int**: Internal firewall zone
- **Business SRVs**: Business servers zone
- **OoB-mgmt**: Out-of-band management zone

## Security Policies

### Inbound Services (from Internet)
- **HTTPS Services**:
  - Extranet (198.19.2.10)
  - WWW (198.19.2.20)
  - Helpdesk (198.19.2.40)
- **DNS Services**:
  - NS1 (198.19.2.4)
  - NS2 (198.19.2.8)
- **Email**:
  - Mail MX (198.19.2.30) - SMTP

### Internal Services
- **DNS**: Internal DNS server (10.0.100.10)
- **HR System**: Staff access to HR services (172.20.0.10)
- **Monitoring**: PRTG monitoring (10.99.0.40)
- **Security**: FireEye integration (10.99.0.30)
- **Log Collection**: SIEM/Elasticsearch (10.99.0.10)

### Outbound Services
- **Web Proxy**: HTTP/HTTPS outbound (10.0.100.70)
- **NTP**: Time synchronization services
- **DNS Resolution**: DNS queries to internet

## Prerequisites

1. **Terraform**: Version 1.x or higher
2. **PAN-OS Provider**: Version 2.0.0
3. **Firewall Access**:
   - Administrative credentials for both firewalls
   - Network connectivity to firewall management interfaces
   - API access enabled on firewalls

## Installation

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd cyber-security-firewall-config
   ```

2. Initialize Terraform:
   ```bash
   terraform init
   ```

## Configuration

### Variables

Create a `terraform.tfvars` file with your firewall credentials:

```hcl
# Internal Firewall
int_hostname = "10.99.0.101"
int_user     = "admin"
int_password = "your-internal-firewall-password"

# External Firewall
ext_hostname = "10.99.0.100"
ext_user     = "admin"
ext_password = "your-external-firewall-password"
```

### Sensitive Variables

The following variables contain sensitive information and should be handled securely:
- `int_password`
- `ext_password`

Consider using:
- Terraform Cloud/Enterprise for variable management
- Environment variables
- Vault integration for production deployments

## Usage

### Plan Deployment
```bash
terraform plan
```

### Apply Configuration
```bash
terraform apply
```

### Destroy Configuration
```bash
terraform destroy
```

## File Structure

```
.
├── providers.tf          # Terraform provider configuration
├── variables.tf          # Input variable definitions
├── terraform.tfvars      # Variable values (create this file)
├── ExtFWsecurity.tf      # External firewall security policies
├── IntFWsecurity.tf      # Internal firewall security policies
├── terraform.tfstate     # Terraform state file (generated)
└── README.md            # This documentation
```

## Security Policies Overview

### Allow Rules
- Web services (HTTPS/SSL)
- DNS resolution
- Email (SMTP)
- Monitoring and management
- Log collection
- NTP synchronization
- LDAP authentication

### Deny Rules
- HTTP traffic (forcing HTTPS)
- Administrative paths
- Unnecessary outbound traffic from DMZ
- Global cleanup rule (catch-all deny)

## Key Security Features

1. **Zone-based Security**: Traffic control between network segments
2. **Application-aware Policies**: Specific application identification
3. **Service-based Filtering**: Port and protocol restrictions
4. **Address-based Controls**: Source/destination IP restrictions
5. **Logging**: Security event logging for monitoring
6. **Default Deny**: Implicit deny for unmatched traffic

## Monitoring and Maintenance

- **PRTG Integration**: Network monitoring capabilities
- **SIEM Integration**: Centralized logging and alerting
- **FireEye Integration**: Advanced threat protection
- **NTP Synchronization**: Time-based security policies

## Troubleshooting

### Common Issues
1. **Authentication Errors**: Verify firewall credentials and API access
2. **Network Connectivity**: Ensure management interface reachability
3. **Policy Conflicts**: Check for overlapping or conflicting rules

### Logs and Debugging
- Enable Terraform debug logging: `export TF_LOG=DEBUG`
- Check firewall system logs for policy application errors
- Verify zone and interface configurations

## Best Practices

1. **Version Control**: Keep infrastructure code in version control
2. **Code Review**: Review policy changes before deployment
3. **Testing**: Test policies in a lab environment first
4. **Documentation**: Maintain up-to-date documentation
5. **Backup**: Backup firewall configurations before changes
6. **Monitoring**: Implement continuous monitoring of security policies

## Contributing

1. Follow the established naming conventions for security rules
2. Document any new variables or configuration changes
3. Test changes in a non-production environment
4. Update this README for significant changes

## License

This project is part of the Cyber Security Implementation in Practice course materials.

## Support

For questions or issues related to this implementation, please refer to the course materials or consult with your instructor.