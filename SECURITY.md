# Security Policy

## Supported Versions

We take security seriously and provide security updates for the following versions:

| Version | Supported          |
| ------- | ------------------ |
| Latest  | :white_check_mark: |
| < 1.0   | :x:                |

## Security Considerations

This project deals with sensitive developer credentials including SSH keys and Git configuration. Please be aware of the following security implications:

### SSH Key Handling
- SSH keys are mounted from the host machine into the container
- Keys maintain their original file permissions
- The setup script automatically sets proper permissions (600/700)
- Keys are only accessible within the container by the `vscode` user

### Git Configuration
- Git configuration is copied from the host `.gitconfig` file
- GPG signing keys are mounted and path-translated for container use
- No sensitive data is logged or exposed in script output
- Configuration is applied at the user level within the container

### Container Security
- Uses the default `vscode` user (non-root)
- Mounts are read-only where possible (Git config)
- SSH keys are mounted with proper permissions
- No privileged container access required

## Reporting a Vulnerability

If you discover a security vulnerability in this project, please report it responsibly:

### How to Report
1. **Do NOT** create a public GitHub issue for security vulnerabilities
2. Email the maintainer directly at: [Your Security Email]
3. Include detailed information about the vulnerability
4. Provide steps to reproduce if possible
5. Allow reasonable time for response and fix

### What to Include
- Description of the vulnerability
- Steps to reproduce the issue
- Potential impact assessment
- Any proposed solutions or mitigations
- Your contact information for follow-up

### Response Timeline
- **Initial Response**: Within 48 hours
- **Assessment**: Within 1 week
- **Fix Development**: Varies based on complexity
- **Public Disclosure**: After fix is released and users have time to update

### Responsible Disclosure
We follow responsible disclosure practices:
- We will acknowledge receipt of your report
- We will provide regular updates on our progress
- We will credit you for the discovery (unless you prefer anonymity)
- We will notify you when the vulnerability is fixed
- We will coordinate public disclosure timing with you

## Security Best Practices for Users

### Host Machine Security
- Keep your SSH keys secure with proper file permissions
- Use strong passphrases for SSH keys
- Regularly rotate SSH keys and GPG keys
- Keep your `.gitconfig` file permissions restrictive
- Use GPG signing for commits when possible

### Container Usage
- Only use trusted base images from official sources
- Keep base images updated to latest versions
- Review any additional features you add to the configuration
- Don't store sensitive data in the container filesystem
- Use the provided configuration without modifications to critical sections

### Network Security
- Be cautious when using development containers on shared networks
- Consider using VPN for remote development
- Verify SSL certificates when cloning repositories
- Use SSH over HTTPS when possible for Git operations

## Known Security Limitations

### Container Isolation
- SSH keys are accessible within the container
- Git configuration is readable by processes in the container
- Standard container isolation applies (not VM-level isolation)

### Host Dependencies
- Security depends on host machine SSH key management
- Host `.gitconfig` security affects container security
- Docker daemon security affects overall system security

### Mitigation Strategies
- Use dedicated development SSH keys when possible
- Consider using SSH agent forwarding as an alternative
- Regularly audit mounted files and permissions
- Keep development containers separate from production workloads

## Security Updates

Security updates will be:
- Released as soon as possible after discovery
- Announced in release notes with severity level
- Communicated through GitHub security advisories
- Documented in the changelog with security implications

## Compliance

This project aims to follow security best practices including:
- Principle of least privilege
- Defense in depth
- Secure by default configuration
- Regular security reviews
- Transparent security practices

## Contact

For security-related questions or concerns:
- Security issues: <security@robertsinfosec.com>
- General questions: Create a GitHub discussion
- Non-security bugs: Create a GitHub issue

---

**Remember**: When in doubt about security, err on the side of caution and reach out to the maintainers for guidance.
