# Contributing to Dev Containers Template

Thank you for your interest in contributing to the Dev Containers Template project! This project aims to make Dev Containers as frictionless as possible for developers who need their Git and SSH configuration to "just work."

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Development Setup](#development-setup)
- [Submitting Changes](#submitting-changes)
- [Issue Guidelines](#issue-guidelines)
- [Pull Request Guidelines](#pull-request-guidelines)
- [Testing](#testing)
- [Style Guidelines](#style-guidelines)

## Code of Conduct

This project adheres to a code of conduct that we expect all contributors to follow. Please be respectful and constructive in all interactions.

## How to Contribute

There are many ways to contribute to this project:

### 🐛 Report Bugs
- Check if the issue already exists in our [issue tracker](../../issues)
- Use the bug report template when creating new issues
- Include detailed reproduction steps and environment information

### 💡 Suggest Features
- Check existing [feature requests](../../issues?q=is%3Aissue+is%3Aopen+label%3Aenhancement)
- Use the feature request template
- Explain the use case and expected behavior

### 📝 Improve Documentation
- Fix typos or unclear explanations
- Add examples for different use cases
- Improve setup instructions

### 🔧 Submit Code Changes
- Fix bugs or implement features
- Follow our coding standards
- Include tests when applicable
- Update documentation as needed

## Development Setup

### Prerequisites
- VS Code with the Dev Containers extension
- Docker Desktop or compatible container runtime
- Git configured on your host machine
- Basic knowledge of Bash scripting and JSON

### Setting Up the Development Environment

1. **Fork and Clone**
   ```bash
   git clone https://github.com/your-username/dev-containers-template.git
   cd dev-containers-template
   ```

2. **Test the Configuration**
   - Open the project in VS Code
   - Use "Dev Containers: Reopen in Container" to test the current setup
   - Verify Git and SSH configuration works correctly

3. **Test on Different Platforms**
   - If possible, test changes on macOS, Linux, and Windows
   - Test with different base images and Git configurations

## Submitting Changes

### Before You Start
1. Check if an issue exists for your change
2. For large changes, discuss the approach in an issue first
3. Make sure you understand the project's goals and scope

### Making Changes

1. **Create a Branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```

2. **Make Your Changes**
   - Follow the [Style Guidelines](#style-guidelines)
   - Test your changes thoroughly
   - Update documentation if needed

3. **Test Your Changes**
   - Test with different Git configurations
   - Test on different operating systems if possible
   - Verify the setup script handles edge cases gracefully

4. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "feat: add support for custom SSH ports"
   # or
   git commit -m "fix: handle missing .gitconfig gracefully"
   ```

5. **Push and Create Pull Request**
   ```bash
   git push origin your-branch-name
   ```

## Issue Guidelines

### Bug Reports
When reporting bugs, please include:
- **Environment**: OS, VS Code version, Docker version
- **Base Image**: Which dev container image you're using
- **Git Configuration**: Relevant parts of your `.gitconfig` (sanitized)
- **SSH Setup**: Whether you use SSH keys, GPG signing, etc.
- **Expected Behavior**: What should happen
- **Actual Behavior**: What actually happens
- **Reproduction Steps**: Minimal steps to reproduce the issue
- **Logs**: Any error messages or relevant output

### Feature Requests
For feature requests, please include:
- **Use Case**: Why is this feature needed?
- **Current Workaround**: How do you handle this today?
- **Proposed Solution**: Your idea for how it should work
- **Alternatives**: Other solutions you've considered

## Pull Request Guidelines

### Before Submitting
- [ ] Your changes work with the existing codebase
- [ ] You've tested on multiple platforms (if possible)
- [ ] Documentation is updated
- [ ] Commit messages follow conventional format
- [ ] Changes are focused and atomic

### PR Description
Include in your PR description:
- **Summary**: Brief description of changes
- **Motivation**: Why is this change needed?
- **Testing**: How you tested the changes
- **Breaking Changes**: Any breaking changes (rare but possible)
- **Related Issues**: Link to any related issues

### Review Process
1. Automated checks will run (if configured)
2. Maintainers will review your code
3. Address any feedback promptly
4. Once approved, a maintainer will merge your PR

## Testing

### Manual Testing Checklist
Test your changes with:

- [ ] **Different Operating Systems**
  - [ ] macOS host
  - [ ] Linux host
  - [ ] Windows host (if possible)

- [ ] **Different Git Configurations**
  - [ ] Basic user.name and user.email
  - [ ] GPG signing enabled
  - [ ] Custom SSH config
  - [ ] Git aliases and custom settings
  - [ ] Missing .gitconfig file

- [ ] **Different Base Images**
  - [ ] Language-specific images (Python, Node.js, etc.)
  - [ ] Platform images (Ubuntu, Alpine, etc.)
  - [ ] Universal image

- [ ] **Edge Cases**
  - [ ] No SSH keys present
  - [ ] Malformed .gitconfig
  - [ ] Permission issues
  - [ ] Network connectivity issues

### Test Scenarios
Create test cases for:
1. Fresh installation with no existing Git config
2. Existing Git config with GPG signing
3. Custom SSH config with non-standard ports
4. Git config with relative paths (~/...)
5. Missing or corrupted SSH keys

## Style Guidelines

### Bash Scripts (`setup-git.sh`)
- Use `#!/usr/bin/env bash` shebang
- Enable strict mode: `set -euo pipefail`
- Use meaningful variable names in UPPER_CASE
- Add comments for complex logic
- Use consistent indentation (4 spaces)
- Handle errors gracefully with informative messages
- Use color-coded output for better UX

### JSON Configuration (`devcontainer.json`)
- Use consistent indentation (tabs, as per VS Code convention)
- Include comments where helpful
- Keep the critical sections (mounts, containerEnv, etc.) unchanged
- Validate JSON syntax

### Documentation
- Use clear, concise language
- Include code examples where helpful
- Keep line length reasonable (80-100 characters)
- Use proper Markdown formatting
- Include cross-references between related sections

### Commit Messages
Follow conventional commits format:
- `feat:` for new features
- `fix:` for bug fixes
- `docs:` for documentation changes
- `style:` for formatting changes
- `refactor:` for code refactoring
- `test:` for test-related changes
- `chore:` for maintenance tasks

Examples:
```
feat: add support for custom SSH agent socket paths
fix: handle Windows path translation for GPG keys
docs: improve troubleshooting section for macOS users
```

## Getting Help

If you need help with development:
- Check existing [issues](../../issues) and [discussions](../../discussions)
- Create a new discussion for questions
- Tag maintainers if you need urgent help

## Recognition

Contributors will be recognized in:
- Release notes for significant contributions
- README acknowledgments
- GitHub contributor graphs

Thank you for helping make Dev Containers better for everyone! 🚀
