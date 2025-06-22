# Configuration Examples

This directory contains example `devcontainer.json` configurations for different development scenarios and tech stacks.

## Quick Reference

| Example | Use Case | Base Image |
|---------|----------|------------|
| [Python Data Science](python-datascience.jsonc) | ML/Data Science with Jupyter | `mcr.microsoft.com/devcontainers/python` |
| [Node.js Web App](nodejs-webapp.jsonc) | React/Vue/Angular development | `mcr.microsoft.com/devcontainers/javascript-node` |
| [Vite React](vite-react.jsonc) | Modern React with Vite | `mcr.microsoft.com/devcontainers/javascript-node` |
| [Hugo SSG](hugo-ssg.jsonc) | Hugo static site generator | `mcr.microsoft.com/devcontainers/hugo` |
| [Jekyll SSG](jekyll-ssg.jsonc) | Jekyll static site generator | `mcr.microsoft.com/devcontainers/jekyll` |
| [Full Stack](fullstack-universal.jsonc) | Multi-language development | `mcr.microsoft.com/devcontainers/universal` |
| [Go Development](golang.jsonc) | Go application development | `mcr.microsoft.com/devcontainers/go` |
| [Java Spring](java-spring.jsonc) | Spring Boot applications | `mcr.microsoft.com/devcontainers/java` |
| [.NET Core](dotnet.jsonc) | C#/.NET development | `mcr.microsoft.com/devcontainers/dotnet` |

## Using These Examples

1. **Choose an example** that matches your tech stack
2. **Copy the content** to your project's `.devcontainer/devcontainer.json`
3. **Customize** the `name` field and any features as needed
4. **Add the setup script** by copying `setup-git.sh` to your `.devcontainer/` folder

## Important Notes

⚠️ **Do NOT modify these sections** in any example:
- `containerEnv`
- `mounts`
- `postCreateCommand`
- `remoteUser`

These are critical for the Git/SSH functionality to work properly.

✅ **Safe to customize**:
- `name`
- `image` (if you need a different version)
- `features`
- `customizations`
- `forwardPorts`
- `portsAttributes`

## Contributing Examples

Have a working configuration for a tech stack not shown here? Please contribute it!

1. Create a new `.jsonc` file following the naming pattern
2. Include a comment at the top describing the use case
3. Test it thoroughly
4. Submit a pull request

See [CONTRIBUTING.md](../../CONTRIBUTING.md) for detailed guidelines.
