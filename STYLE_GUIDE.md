# Style Guide

This document outlines the coding and documentation standards for the Dev Containers Template project.

## Table of Contents

- [General Principles](#general-principles)
- [Bash Scripting](#bash-scripting)
- [JSON Configuration](#json-configuration)
- [Documentation](#documentation)
- [Git Conventions](#git-conventions)
- [File Organization](#file-organization)

## General Principles

### Consistency
- Follow established patterns within the codebase
- Use consistent naming conventions throughout
- Maintain consistent indentation and formatting

### Clarity
- Write code that is self-documenting
- Use meaningful variable and function names
- Add comments for complex or non-obvious logic
- Prefer explicit over implicit behavior

### Robustness
- Handle edge cases gracefully
- Provide informative error messages
- Validate inputs where appropriate
- Use defensive programming practices

### User Experience
- Provide clear, colored output messages
- Include progress indicators for long operations
- Offer helpful suggestions when errors occur
- Make the setup process as automated as possible

## Bash Scripting

### File Structure
```bash
#!/usr/bin/env bash

# Script: script-name.sh
# Description: Brief description of what the script does
# Usage: How to call the script

set -euo pipefail

# --- Constants and Configuration ---
SCRIPT_NAME="$(basename "$0")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# --- Colors ---
RED='\033[31m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
CYAN='\033[36m'
GRAY='\033[90m'
RESET='\033[0m'

# --- Functions ---
function main() {
    # Main script logic here
}

# --- Script Execution ---
main "$@"
```

### Naming Conventions
- **Variables**: Use `UPPER_CASE` for constants, `lower_case` for local variables
- **Functions**: Use `snake_case` for function names
- **Files**: Use `kebab-case` for script filenames

### Error Handling
```bash
# Use strict mode
set -euo pipefail

# Check prerequisites
if ! command -v git &> /dev/null; then
    echo -e "${RED}[!] Git is not installed${RESET}" >&2
    exit 1
fi

# Validate file existence
if [[ ! -f "$CONFIG_FILE" ]]; then
    echo -e "${YELLOW}[!] Config file not found: $CONFIG_FILE${RESET}" >&2
    return 1
fi
```

### Output Messages
Use consistent message formatting with color coding:

```bash
# Information messages
echo -e "${CYAN}[*] Processing Git configuration${RESET}"

# Success messages
echo -e "${GREEN}[+] Configuration applied successfully${RESET}"

# Warning messages
echo -e "${YELLOW}[!] SSH keys not found - continuing without SSH setup${RESET}"

# Error messages
echo -e "${RED}[!] Failed to read configuration file${RESET}" >&2

# Debug/detail messages
echo -e "${GRAY}[%] Using config file: $CONFIG_FILE${RESET}"
```

### Path Handling
```bash
# Use absolute paths when possible
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Handle paths with spaces
cp "$source_file" "$destination_file"

# Use parameter expansion for path manipulation
filename="${path##*/}"        # basename
directory="${path%/*}"        # dirname
extension="${filename##*.}"   # file extension
```

### Conditionals and Loops
```bash
# Prefer [[ ]] over [ ]
if [[ -f "$file" && -r "$file" ]]; then
    echo "File exists and is readable"
fi

# Use meaningful test conditions
while IFS= read -r line; do
    [[ -z "$line" ]] && continue  # Skip empty lines
    process_line "$line"
done < "$input_file"
```

## JSON Configuration

### Formatting
- Use tabs for indentation (VS Code standard)
- Include trailing commas where allowed
- Use double quotes for all strings
- Add comments where helpful (JSONC format)

### Example Structure
```jsonc
{
    "name": "Project Name",
    "image": "base-image:tag",
    
    // Feature configuration
    "features": {
        "ghcr.io/devcontainers/features/git-lfs:1": {},
        "ghcr.io/devcontainers/features/github-cli:1": {
            "installDirectlyFromGitHubRelease": true
        }
    },
    
    // Environment setup (DO NOT MODIFY)
    "containerEnv": {
        "SSH_AUTH_SOCK": "/tmp/ssh-agent.sock"
    },
    
    // Critical mounts (DO NOT MODIFY)
    "mounts": [
        "source=${localEnv:HOME}/.ssh,target=/home/vscode/.ssh,type=bind,consistency=cached",
        "source=${localEnv:HOME}/.gitconfig,target=/tmp/host-gitconfig,type=bind,consistency=cached,readonly"
    ],
    
    // Setup script execution (DO NOT MODIFY)
    "postCreateCommand": "chmod +x .devcontainer/setup-git.sh && .devcontainer/setup-git.sh",
    
    // User configuration (DO NOT MODIFY)
    "remoteUser": "vscode"
}
```

### Configuration Sections
- **Customizable**: `name`, `image`, `features`, `customizations`
- **Critical (Don't Modify)**: `containerEnv`, `mounts`, `postCreateCommand`, `remoteUser`

## Documentation

### Markdown Standards
- Use ATX-style headers (`#`, `##`, `###`)
- Include a table of contents for longer documents
- Use code fences with language specification
- Keep line length under 100 characters
- Use relative links for internal references

### Code Examples
Always include complete, working examples:

```markdown
### Example Configuration

```json
{
    "name": "Python Development",
    "image": "mcr.microsoft.com/devcontainers/python:3.11",
    "features": {
        "ghcr.io/devcontainers/features/git-lfs:1": {}
    }
}
```

This configuration creates a Python 3.11 development environment with Git LFS support.
```

### README Structure
1. **Project Overview**: Brief description and key benefits
2. **Quick Start**: Immediate getting-started steps
3. **Detailed Usage**: Comprehensive usage instructions
4. **Configuration**: Available options and customization
5. **Troubleshooting**: Common issues and solutions
6. **Contributing**: How to contribute to the project

## Git Conventions

### Commit Messages
Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

**Types:**
- `feat`: New features
- `fix`: Bug fixes
- `docs`: Documentation changes
- `style`: Code formatting changes
- `refactor`: Code refactoring
- `test`: Test additions or modifications
- `chore`: Maintenance tasks

**Examples:**
```
feat: add support for custom SSH agent socket paths

- Allow users to specify custom SSH_AUTH_SOCK paths
- Maintain backward compatibility with default setup
- Update documentation with new configuration option

Closes #123
```

```
fix: handle Windows path translation for GPG keys

The path translation logic was not properly handling Windows-style
paths (C:\Users\...). This fix adds Windows path detection and
proper translation to container paths.

Fixes #456
```

### Branch Naming
- `feature/description`: New features
- `fix/description`: Bug fixes
- `docs/description`: Documentation updates
- `refactor/description`: Code refactoring

Examples:
- `feature/windows-path-support`
- `fix/ssh-permission-handling`
- `docs/improve-troubleshooting`

## File Organization

### Directory Structure
```
dev-containers-template/
├── .devcontainer/           # Core configuration files
│   ├── devcontainer.json   # Container configuration
│   └── setup-git.sh        # Git setup script
├── docs/                   # Additional documentation
│   ├── examples/          # Usage examples
│   └── troubleshooting/   # Detailed troubleshooting guides
├── tests/                  # Test scripts and fixtures
├── .github/               # GitHub-specific files
│   ├── ISSUE_TEMPLATE/    # Issue templates
│   └── workflows/         # CI/CD workflows
├── CONTRIBUTING.md        # Contribution guidelines
├── STYLE_GUIDE.md        # This file
├── SECURITY.md           # Security policy
├── CHANGELOG.md          # Change log
├── LICENSE               # License file
└── README.md             # Main documentation
```

### File Naming
- Use `kebab-case` for script files and documentation
- Use `PascalCase` for special GitHub files (CONTRIBUTING.md, README.md)
- Use descriptive names that indicate file purpose
- Include file extensions for clarity

### Template Files
When creating template or example files:
- Use clear, meaningful names
- Include comprehensive comments
- Provide multiple examples for different use cases
- Ensure examples are tested and working

## Validation and Testing

### Pre-commit Checklist
- [ ] Code follows style guidelines
- [ ] All variables are properly quoted
- [ ] Error handling is implemented
- [ ] Output messages are clear and helpful
- [ ] Documentation is updated
- [ ] Examples are tested and working

### Testing Guidelines
- Test on multiple operating systems when possible
- Verify with different base images
- Test edge cases (missing files, permission issues)
- Validate JSON syntax
- Check script execution with `shellcheck` if available

## Tools and Linting

### Recommended Tools
- **ShellCheck**: For bash script linting
- **JSON Lint**: For JSON validation
- **Prettier**: For Markdown formatting
- **VS Code Extensions**: Dev Containers, GitLens, Markdown All in One

### Integration
Consider adding these tools to the development workflow:
- Pre-commit hooks for validation
- GitHub Actions for automated testing
- Documentation generation tools

---

Following these guidelines helps maintain a consistent, professional, and user-friendly codebase. When in doubt, prioritize clarity and user experience over clever solutions.
