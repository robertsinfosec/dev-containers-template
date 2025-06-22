# Troubleshooting Guide

This guide helps you resolve common issues when using the Dev Containers Template.

## Table of Contents

- [SSH Issues](#ssh-issues)
- [Git Configuration Problems](#git-configuration-problems)
- [Container Startup Issues](#container-startup-issues)
- [Permission Problems](#permission-problems)
- [Platform-Specific Issues](#platform-specific-issues)
- [Performance Issues](#performance-issues)
- [Getting Help](#getting-help)

## SSH Issues

### SSH Keys Not Working

**Problem**: Can't clone repositories or push changes using SSH.

**Solutions**:

1. **Check SSH key existence**:
   ```bash
   ls -la ~/.ssh/
   ```
   You should see files like `id_rsa`, `id_ed25519`, or similar.

2. **Verify SSH key permissions**:
   ```bash
   chmod 700 ~/.ssh
   chmod 600 ~/.ssh/id_*
   chmod 644 ~/.ssh/*.pub
   ```

3. **Test SSH connection**:
   ```bash
   ssh -T git@github.com
   ```

4. **Check SSH agent**:
   ```bash
   echo $SSH_AUTH_SOCK
   ssh-add -l
   ```

### SSH Config Not Applied

**Problem**: Custom SSH configuration isn't working in the container.

**Solutions**:

1. **Verify SSH config exists on host**:
   ```bash
   cat ~/.ssh/config
   ```

2. **Check config permissions**:
   ```bash
   chmod 600 ~/.ssh/config
   ```

3. **Common SSH config example**:
   ```
   Host github.com
       HostName github.com
       User git
       Port 22
       IdentityFile ~/.ssh/id_rsa
   ```

### SSH Agent Socket Issues

**Problem**: SSH agent socket not found or not working.

**Solutions**:

1. **Start SSH agent on host**:
   ```bash
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_rsa
   ```

2. **Check container environment**:
   ```bash
   echo $SSH_AUTH_SOCK
   ```

3. **Manual SSH agent setup** (if needed):
   ```bash
   ssh-agent -a /tmp/ssh-agent.sock
   export SSH_AUTH_SOCK=/tmp/ssh-agent.sock
   ```

## Git Configuration Problems

### Git User Not Set

**Problem**: Commits show as "unknown" or wrong user.

**Solutions**:

1. **Check host Git config**:
   ```bash
   git config --global user.name
   git config --global user.email
   ```

2. **Verify container Git config**:
   ```bash
   git config --global --list
   ```

3. **Manually set if needed**:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

### GPG Signing Not Working

**Problem**: Can't sign commits with GPG keys.

**Solutions**:

1. **Check GPG keys on host**:
   ```bash
   gpg --list-secret-keys --keyid-format=long
   ```

2. **Verify signing key path**:
   ```bash
   git config --global user.signingkey
   ```

3. **Check if key exists in container**:
   ```bash
   ls -la ~/.ssh/id_*
   ```

4. **Import GPG key if using GPG instead of SSH**:
   ```bash
   gpg --import ~/.ssh/private.gpg
   ```

### Git Aliases Missing

**Problem**: Custom Git aliases not available in container.

**Solutions**:

1. **Check host aliases**:
   ```bash
   git config --global --get-regexp alias
   ```

2. **Verify setup script ran**:
   ```bash
   cat ~/.gitconfig
   ```

3. **Re-run setup if needed**:
   ```bash
   ./.devcontainer/setup-git.sh
   ```

## Container Startup Issues

### Container Won't Start

**Problem**: Dev container fails to start or build.

**Solutions**:

1. **Check Docker is running**:
   ```bash
   docker --version
   docker ps
   ```

2. **Verify JSON syntax**:
   ```bash
   jq empty .devcontainer/devcontainer.json
   ```

3. **Check base image availability**:
   ```bash
   docker pull mcr.microsoft.com/devcontainers/python:3.11
   ```

4. **Clear Docker cache**:
   ```bash
   docker system prune -f
   ```

### Setup Script Fails

**Problem**: `setup-git.sh` fails during container creation.

**Solutions**:

1. **Check script permissions**:
   ```bash
   ls -la .devcontainer/setup-git.sh
   ```

2. **Run script manually**:
   ```bash
   bash .devcontainer/setup-git.sh
   ```

3. **Check for syntax errors**:
   ```bash
   bash -n .devcontainer/setup-git.sh
   ```

4. **View detailed output**:
   ```bash
   bash -x .devcontainer/setup-git.sh
   ```

### Missing Files or Mounts

**Problem**: Host files not accessible in container.

**Solutions**:

1. **Check mount syntax**:
   ```json
   "mounts": [
     "source=${localEnv:HOME}/.ssh,target=/home/vscode/.ssh,type=bind,consistency=cached"
   ]
   ```

2. **Verify file existence**:
   ```bash
   ls -la ~/.ssh/
   ls -la ~/.gitconfig
   ```

3. **Check environment variables**:
   ```bash
   echo $HOME
   ```

## Permission Problems

### SSH Permission Denied

**Problem**: Permission denied when accessing SSH keys.

**Solutions**:

1. **Fix SSH permissions**:
   ```bash
   chmod 700 ~/.ssh
   chmod 600 ~/.ssh/id_*
   chmod 644 ~/.ssh/*.pub
   chmod 600 ~/.ssh/config
   ```

2. **Check file ownership**:
   ```bash
   ls -la ~/.ssh/
   ```

3. **Run setup script again**:
   ```bash
   ./.devcontainer/setup-git.sh
   ```

### Git Config Permission Issues

**Problem**: Can't read or write Git configuration.

**Solutions**:

1. **Check .gitconfig permissions**:
   ```bash
   ls -la ~/.gitconfig
   ```

2. **Fix permissions**:
   ```bash
   chmod 644 ~/.gitconfig
   ```

3. **Check mount is read-only**:
   The host `.gitconfig` is mounted read-only intentionally.

## Platform-Specific Issues

### macOS Issues

**Common Problems**:

1. **Docker Desktop not running**:
   - Start Docker Desktop application
   - Check Docker Desktop settings

2. **Path translation issues**:
   - Host paths: `/Users/username/`
   - Container paths: `/home/vscode/`

3. **File sharing permissions**:
   - Check Docker Desktop file sharing settings
   - Ensure project directory is shared

### Windows Issues

**Common Problems**:

1. **WSL2 integration**:
   - Enable WSL2 integration in Docker Desktop
   - Use WSL2 file system for better performance

2. **Path format issues**:
   - Use Unix-style paths in configuration
   - Avoid Windows drive letters (C:\)

3. **Line ending issues**:
   ```bash
   git config --global core.autocrlf input
   ```

### Linux Issues

**Common Problems**:

1. **Docker permissions**:
   ```bash
   sudo usermod -aG docker $USER
   # Log out and back in
   ```

2. **SELinux context**:
   ```bash
   chcon -Rt svirt_sandbox_file_t ~/.ssh/
   ```

## Performance Issues

### Slow Container Startup

**Solutions**:

1. **Use faster consistency settings**:
   ```json
   "mounts": [
     "source=...,target=...,type=bind,consistency=cached"
   ]
   ```

2. **Reduce image size**:
   - Use specific language images instead of `universal`
   - Remove unnecessary features

3. **Enable buildkit**:
   ```bash
   export DOCKER_BUILDKIT=1
   ```

### Slow File Operations

**Solutions**:

1. **Use bind mounts for code**:
   - Keep source code in bind mounts
   - Use volumes for dependencies

2. **Optimize mount consistency**:
   - `cached`: Host authoritative (good for code)
   - `delegated`: Container authoritative (good for builds)

## Getting Help

### Information to Gather

When asking for help, please provide:

1. **Environment details**:
   ```bash
   # Host OS and version
   uname -a
   
   # VS Code version
   code --version
   
   # Docker version  
   docker --version
   
   # Dev Containers extension version
   # (Check in VS Code extensions)
   ```

2. **Configuration files**:
   - Your `devcontainer.json` (sanitized)
   - Any error messages
   - Relevant log output

3. **Steps to reproduce**:
   - What you were trying to do
   - What happened vs. what you expected

### Where to Get Help

1. **GitHub Issues**: For bugs and feature requests
2. **GitHub Discussions**: For questions and community help  
3. **VS Code Dev Containers Documentation**: Official guidance
4. **Docker Documentation**: For container-related issues

### Self-Help Checklist

Before asking for help:

- [ ] Read this troubleshooting guide
- [ ] Check the main README
- [ ] Verify your configuration against examples
- [ ] Test with a minimal configuration
- [ ] Search existing GitHub issues
- [ ] Try with a fresh container build

---

**Remember**: Most issues are related to file permissions, path translation, or missing files on the host machine. Start with the basics and work your way up to more complex solutions.
