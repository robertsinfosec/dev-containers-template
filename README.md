# Dev Containers Template

A lift-and-load VS Code Dev Containers configuration that seamlessly handles Git configuration and SSH key conveyance from your host machine to the containerized development environment.

> [!NOTE]
> ## TL;DR - Quick Start
> 
> 1. **Copy these files** to your project's `.devcontainer/` folder:
>    - [`devcontainer.json`](.devcontainer/devcontainer.json) 
>    - [`setup-git.sh`](.devcontainer/setup-git.sh)
>    - [`post-setup.sh`](.devcontainer/post-setup.sh)
> 2. **Customize** the `image` and `features` in `devcontainer.json` for your tech stack
> 3. **Browse [examples](docs/examples/)** for ready-to-use configurations (Python, React, Java, etc.)
> 4. **Open in VS Code** and use "Dev Containers: Reopen in Container" 
>    
>    [![Install Dev Containers Extension](https://img.shields.io/badge/VS%20Code-Install%20Extension-blue?logo=visual-studio-code)](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
> 
> Your Git config and SSH keys will work automatically inside of the Dev Container for your workspace.

## What are VS Code "Dev Containers"?

VS Code Dev Containers is a powerful feature that allows you to use a Docker container as a complete development environment. When you open a project in VS Code, it can automatically spin up a containerized environment with all the tools, libraries, and dependencies your project needs, creating a consistent development experience across different machines and team members.

Key benefits include:
- **Isolated environments**: Each project gets its own containerized environment
- **Reproducible setups**: Same environment for all developers on your team
- **Tool consistency**: Specific versions of languages, frameworks, and tools
- **Easy onboarding**: New team members can start coding immediately

## Why use Dev Containers?

Dev Containers solve several common development pain points:

### Environment Consistency
- Eliminates "works on my machine" problems
- Ensures all team members use identical development environments
- Prevents version conflicts between different projects

### Simplified Setup
- No need to install multiple language runtimes or tools locally
- Automatic dependency management
- Pre-configured development tools and extensions

### Project Isolation
- Different projects can use different versions of the same tools
- Avoid polluting your host machine with project-specific dependencies
- Easy to experiment with new tools without affecting other projects

### Onboarding Speed
- New developers can be productive in minutes, not hours or days
- No lengthy setup documentation or manual configuration steps
- Consistent experience regardless of host operating system

## Common Dev Container "Gotchas"

While Dev Containers are powerful, there are several common issues that can frustrate developers:

### 1. Git Configuration Loss
By default, your personal Git configuration (name, email, signing keys, aliases) doesn't transfer to the container. This means:
- Commits may appear as coming from "unknown" authors
- GPG signing won't work without additional setup
- Custom Git aliases and settings are unavailable
- Authentication credentials aren't automatically available

### 2. SSH Key Accessibility
SSH keys stored on your host machine aren't automatically available in the container, causing:
- Inability to clone private repositories
- Failed authentication when pushing to remote repositories
- Need to recreate or copy SSH keys manually
- Loss of SSH config settings for custom hosts

### 3. Path Translation Issues
Different operating systems use different path structures:
- macOS: `/Users/username/`
- Linux: `/home/username/`
- Windows: `/c/Users/username/`
- Container: `/home/vscode/` (when using the default `vscode` user)

This creates problems when trying to mount or reference files between host and container.

## What This Template Solves

This repository provides a complete solution that addresses all the common gotchas mentioned above. The [.devcontainer](.devcontainer) folder contains three key files:

### `devcontainer.json` - Container Configuration
This file handles the Docker container setup and critical mounts:

```json
{
  "name": "Your Project",
  "image": "your-base-image",
  "features": {
    // Your required dev container features
  },
  "containerEnv": {
    "SSH_AUTH_SOCK": "/tmp/ssh-agent.sock"
  },
  "mounts": [
    "source=${localEnv:HOME}/.ssh,target=/home/vscode/.ssh,type=bind,consistency=cached",
    "source=${localEnv:HOME}/.gitconfig,target=/tmp/host-gitconfig,type=bind,consistency=cached,readonly"
  ],
  "postCreateCommand": "chmod +x .devcontainer/setup-git.sh .devcontainer/post-setup.sh && .devcontainer/setup-git.sh && .devcontainer/post-setup.sh",
  "remoteUser": "vscode"
}
```

**Key features:**
- **SSH Agent Support**: Sets up SSH agent socket for authentication
- **SSH Key Mount**: Safely mounts your `~/.ssh` directory from host to container
- **Git Config Mount**: Mounts your host `.gitconfig` to a temporary location for processing
- **Automatic Setup**: Runs the setup script after container creation

### `setup-git.sh` - Intelligent Configuration Script
This Bash script handles the complex task of translating your host Git configuration to work properly in the container:

**What it does:**
1. **SSH Permission Fix**: Ensures proper file permissions on SSH keys and config
2. **Path Translation**: Automatically converts host paths to container paths for signing keys
3. **Git Config Processing**: Reads your host Git configuration and applies it to the container
4. **Cross-Platform Support**: Works seamlessly on macOS, Linux, and Windows hosts
5. **Error Handling**: Gracefully handles missing files and provides helpful feedback

**Path translation examples:**
- `/Users/john/.ssh/id_rsa` → `/home/vscode/.ssh/id_rsa` (macOS to container)
- `/home/john/.ssh/id_rsa` → `/home/vscode/.ssh/id_rsa` (Linux to container)
- `~/.ssh/id_rsa` → `/home/vscode/.ssh/id_rsa` (relative to absolute)

**Git configuration preserved:**
- User name and email
- GPG signing configuration and keys
- Git aliases and custom settings
- SSH configuration for custom hosts

### `post-setup.sh` - Project-Specific Customization
This script runs after Git/SSH setup is complete, providing a place for project-specific configuration:

**What it handles:**
- Installing additional development tools and dependencies
- Setting up project dependencies (bundle install, npm install, etc.)
- Customizing shell environment (.bashrc aliases and shortcuts)
- Starting required services (databases, Docker daemon, etc.)
- Initial project setup and configuration

**Jekyll example:**
```bash
#!/bin/bash
# Install Jekyll dependencies
bundle install

# Add helpful aliases to .bashrc
echo 'alias jstart="bundle exec jekyll serve --host 0.0.0.0 --livereload"' >> ~/.bashrc
echo 'alias jbuild="bundle exec jekyll build"' >> ~/.bashrc

# Optional: Start Docker daemon for containerized services
# sudo service docker start
```

**Key capabilities:**
- **Full sudo access**: Install system packages and modify system configuration
- **Git already configured**: Your Git config and SSH keys are available
- **Shell customization**: Persistent aliases and environment variables
- **Project automation**: Run setup commands specific to your tech stack

## How to Use This Template

### 1. Copy the Configuration Files
Copy the `.devcontainer` folder and its contents to your project root:
```
your-project/
├── .devcontainer/
│   ├── devcontainer.json
│   ├── setup-git.sh
│   └── post-setup.sh
├── src/
└── README.md
```

### 2. Customize for Your Tech Stack
Edit the `devcontainer.json` file to match your project's requirements and update `post-setup.sh` for your project-specific needs.

**For a Jekyll site:**
```json
{
  "name": "Jekyll Site",
  "image": "mcr.microsoft.com/devcontainers/jekyll:2-bullseye",
  "features": {
    "ghcr.io/devcontainers/features/github-cli:1": {}
  },
  // ... keep the rest of the configuration unchanged
}
```

**For other projects:**
- Choose the appropriate base image for your language/framework
- Customize `post-setup.sh` with your project's setup commands
- Add any required features to the `features` section

**Important**: Only modify the `name`, `image`, and `features` sections. The `containerEnv`, `mounts`, `postCreateCommand`, and `remoteUser` sections are critical for the Git/SSH functionality.

### 3. Open in Dev Container
1. Open your project in VS Code
2. Press `F1` and run "Dev Containers: Reopen in Container"
3. VS Code will build the container and run the setup script automatically
4. Your Git config and SSH keys will be ready to use!

## Supported Base Images

**Customization Points**

**Base Images** - Change the `image` field for your tech stack:
- Jekyll: `mcr.microsoft.com/devcontainers/jekyll:2-bullseye`
- Python: `mcr.microsoft.com/devcontainers/python:3.11`
- Node.js: `mcr.microsoft.com/devcontainers/node:18`
- Universal: `mcr.microsoft.com/devcontainers/universal:2`

**Project Setup** - Customize `post-setup.sh` for your needs:
- Package installation: `bundle install`, `npm install`, `pip install -r requirements.txt`
- Development aliases and shortcuts
- Service startup: Docker, databases, etc.
- Project-specific configuration

Find more images at: https://github.com/devcontainers/images

## Using Custom Dockerfiles

If you need more control than the pre-built images provide, you can use a custom Dockerfile. Here's the recommended setup for the `vscode` user with Docker-in-Docker and sudo access:

```dockerfile
# Create non-root user and add to sudoers + docker group
RUN addgroup -g 1000 vscode && \
    adduser -u 1000 -G vscode -s /bin/bash -D vscode && \
    echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && \
    usermod -aG docker vscode

USER vscode
```

In your `.devcontainer/devcontainer.json`, ensure you set:
```json
{
  "build": {
    "dockerfile": "Dockerfile"
  },
  "remoteUser": "vscode"
  // ... rest of configuration
}
```

**Why this setup works:**
- **Interactive development**: Unlike production containers, dev containers benefit from sudo access for installing tools and dependencies
- **Docker-in-Docker compatibility**: The `vscode` user is added to the `docker` group for container management
- **Consistent user experience**: Uses the same user setup as Microsoft's official dev container images

## Troubleshooting

### SSH Keys Not Working
- Ensure your SSH keys exist in `~/.ssh/` on your host machine
- Check that key files have proper permissions (600 for private keys)
- Verify your SSH config is properly formatted

### Git Signing Issues
- Make sure your GPG keys are available on the host
- Check that the signing key path in your Git config is correct
- The script will automatically translate paths, but the keys must exist

### Permission Errors
- The setup script automatically fixes SSH permissions
- If you encounter issues, the script provides detailed error messages
- Check the container logs for specific error details

### post-setup.sh Not Running
- Ensure the file exists in `.devcontainer/post-setup.sh`
- The script runs automatically via `postCreateCommand` - no manual execution needed
- Check VS Code's terminal output for any error messages during container creation

### Custom Commands Not Working
- Aliases added to `.bashrc` require a new terminal session to take effect
- For immediate access, run `source ~/.bashrc` or open a new terminal

## Additional Resources

### 📚 Documentation
- **[Configuration Examples](docs/examples/)**: Ready-to-use configurations for different tech stacks
- **[Troubleshooting Guide](docs/troubleshooting/)**: Solutions for common issues
- **[Style Guide](STYLE_GUIDE.md)**: Coding and documentation standards
- **[Contributing Guide](CONTRIBUTING.md)**: How to contribute to this project
- **[Security Policy](SECURITY.md)**: Security considerations and reporting
- **[Changelog](CHANGELOG.md)**: Version history and release notes

### 🛠️ Configuration Examples
Quick links to popular configurations:
- [Python Data Science](docs/examples/python-datascience.jsonc) - Jupyter, pandas, scikit-learn
- [Node.js Web App](docs/examples/nodejs-webapp.jsonc) - React, Vue, Angular
- [Vite React](docs/examples/vite-react.jsonc) - Modern React with fast HMR
- [Hugo SSG](docs/examples/hugo-ssg.jsonc) - Hugo static site generator  
- [Jekyll SSG](docs/examples/jekyll-ssg.jsonc) - Jekyll static site generator
- [Java Spring Boot](docs/examples/java-spring.jsonc) - Enterprise Java development  
- [.NET Core](docs/examples/dotnet.jsonc) - ASP.NET Core, Blazor
- [Go Development](docs/examples/golang.jsonc) - Go applications and microservices
- [Full Stack Universal](docs/examples/fullstack-universal.jsonc) - Multi-language support

### 🚀 Getting Started Quickly
1. **Browse Examples**: Check the [examples directory](docs/examples/) for your tech stack
2. **Copy Configuration**: Copy the example that matches your needs
3. **Customize**: Update the `name`, `image`, and `features` for your project
4. **Copy Setup Script**: Don't forget to copy `setup-git.sh` to your `.devcontainer/` folder
5. **Open in Container**: Use VS Code's "Reopen in Container" command

## Contributing

Feel free to submit issues and pull requests to improve this template. The goal is to make Dev Containers as frictionless as possible for developers who need their Git and SSH configuration to "just work."


