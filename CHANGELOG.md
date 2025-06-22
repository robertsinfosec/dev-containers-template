# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial open source project structure
- Contributing guidelines and style guide
- Security policy documentation
- Comprehensive README with detailed examples

### Changed
- N/A

### Deprecated
- N/A

### Removed
- N/A

### Fixed
- N/A

### Security
- N/A

## [1.0.0] - 2025-06-22

### Added
- Core Dev Container configuration (`devcontainer.json`)
- Intelligent Git setup script (`setup-git.sh`)
- Cross-platform path translation for Git signing keys
- SSH key mounting and permission management
- Host Git configuration preservation
- Support for GPG signing in containers
- Colored console output for better user experience
- Error handling and graceful degradation
- Jekyll base image example configuration

### Features
- **Git Configuration Transfer**: Seamlessly copies host Git config to container
- **SSH Key Access**: Mounts and configures SSH keys from host machine
- **Path Translation**: Automatically converts host paths to container paths
- **Cross-Platform Support**: Works on macOS, Linux, and Windows hosts
- **Permission Management**: Automatically sets correct SSH file permissions
- **GPG Signing Support**: Preserves GPG signing configuration and keys
- **Error Recovery**: Graceful handling of missing files and edge cases

### Security
- SSH keys mounted with proper permissions (600/700)
- Read-only mounting of Git configuration
- Non-root user execution (vscode user)
- No sensitive data exposure in logs

---

## Release Notes Template

When creating new releases, use this template:

```markdown
## [Version] - YYYY-MM-DD

### Added
- New features or capabilities

### Changed
- Changes to existing functionality

### Deprecated
- Features that will be removed in future versions

### Removed
- Features that have been removed

### Fixed
- Bug fixes

### Security
- Security improvements or fixes
```

### Categories Explained

- **Added**: New features, capabilities, or files
- **Changed**: Modifications to existing functionality that don't break compatibility
- **Deprecated**: Features marked for removal in future versions
- **Removed**: Features that have been completely removed
- **Fixed**: Bug fixes and error corrections
- **Security**: Security-related improvements or vulnerability fixes

### Versioning Guidelines

This project follows [Semantic Versioning](https://semver.org/):

- **MAJOR** (X.0.0): Breaking changes that require user action
- **MINOR** (0.X.0): New features that are backward compatible
- **PATCH** (0.0.X): Bug fixes and minor improvements

### Examples of Version Bumps

**MAJOR (2.0.0)**:
- Changing the required directory structure
- Modifying the setup script API or parameters
- Requiring different base image configurations

**MINOR (1.1.0)**:
- Adding support for new base images
- Adding new configuration options
- Improving error messages or user experience

**PATCH (1.0.1)**:
- Fixing path translation bugs
- Correcting permission issues
- Updating documentation
