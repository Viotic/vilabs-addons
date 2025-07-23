---
applyTo: '**'
---
# Home Assistant Add-on Development Guidelines

## Repository Structure

```
vilabs-addons/
├── README.md
├── repository.json
├── .github/
│   └── workflows/         # CI/CD automation
├── addon-name/
│   ├── config.yaml        # Add-on configuration
│   ├── build.yaml         # Build configuration
│   ├── Dockerfile         # Container definition
│   ├── run.sh            # Startup script
│   ├── README.md         # User documentation
│   ├── DOCS.md           # Detailed documentation
│   ├── CHANGELOG.md      # Version history
│   ├── translations/     # Localization
│   └── icon.png          # Add-on icon
```

## Core Development Principles

### 1. Simplicity First
- Use `init: false` for simple web services
- Avoid S6 overlay unless multiple processes needed
- Single responsibility per add-on

### 2. Configuration Schema
```yaml
# config.yaml template
name: "Add-on Name"
version: "1.0.0"
slug: addon-slug
description: "Brief description"
url: "https://github.com/author/repo"
arch: [aarch64, amd64, armv7]
init: false
startup: services
ports:
  3000/tcp: 3000
map:
  - data:rw
options:
  # Default values
schema:
  # Validation rules
ingress: true
ingress_port: 3000
panel_icon: mdi:icon-name
```

### 3. Dockerfile Best Practices
```dockerfile
ARG BUILD_FROM
FROM ${BUILD_FROM}

# Install dependencies in single layer
RUN apk add --no-cache package1 package2

# Build arguments for metadata
ARG BUILD_ARCH BUILD_DATE BUILD_DESCRIPTION BUILD_NAME BUILD_REF BUILD_REPOSITORY BUILD_VERSION

# Required labels
LABEL io.hass.name="${BUILD_NAME}" \
      io.hass.type="addon" \
      io.hass.arch="${BUILD_ARCH}"

# Copy and set permissions
COPY run.sh /
RUN chmod a+x /run.sh

# Health check with actual service check
HEALTHCHECK CMD curl -f http://localhost:PORT/ || exit 1

CMD ["/run.sh"]
```

### 4. Run Script Pattern
```bash
#!/usr/bin/with-contenv bashio

set -e

bashio::log.info "Starting service..."

# Create data directory
mkdir -p /data

# Read configuration
CONFIG_VALUE=$(bashio::config 'config_key')

# Set environment variables
export SERVICE_VAR="$CONFIG_VALUE"

# Start service
exec service-command --port 3000 --host 0.0.0.0
```

## Development Environment

### Local Testing
```bash
# Build locally
docker build -t local/addon-test .

# Test run
docker run --rm -p 3000:3000 \
  -v $(pwd)/data:/data \
  -e CONFIG_JSON='{"key":"value"}' \
  local/addon-test
```

### VS Code Setup
```json
// .vscode/settings.json
{
  "yaml.schemas": {
    "https://developers.home-assistant.io/schemas/addon/config.json": "*/config.yaml"
  }
}
```

## Configuration Patterns

### Environment Variables
```bash
# Optional with default
export VAR=${CONFIG_VAR:-"default"}

# Required configuration
if bashio::config.is_empty 'required_key'; then
  bashio::exit.nok "Required configuration missing"
fi

# Boolean handling
if bashio::config.true 'enable_feature'; then
  export ENABLE_FEATURE=true
fi
```

### Secrets Management
```yaml
# config.yaml
schema:
  api_key: password

# run.sh
API_KEY=$(bashio::config 'api_key')
export SERVICE_API_KEY="$API_KEY"
```

## Common Patterns by Service Type

### Web Services (React/Node.js)
```dockerfile
# Use specific Node version
RUN apk add --no-cache nodejs npm

# Clone and build
RUN git clone --depth 1 https://github.com/org/repo.git . && \
    npm ci && \
    npm run build
```

### Python Services
```dockerfile
# Install Python dependencies
RUN pip3 install --no-cache-dir package==version

# Handle dependency conflicts
RUN pip3 install --no-cache-dir \
    package1 \
    package2 \
    && pip3 install --no-deps target-package
```

### AI/ML Services
```yaml
# config.yaml - Common AI service options
options:
  model_provider: "openai"
  api_key: ""
  base_url: ""
  model_list: ""
  enable_streaming: true
```

## Security Best Practices

### Permissions
```yaml
# Minimal permissions
hassio_api: true
hassio_role: default  # or manager if needed
privileged: []
host_network: false
```

### Input Validation
```bash
# Validate URLs
if ! bashio::var.matches "$(bashio::config 'url')" "^https?://"; then
  bashio::exit.nok "Invalid URL format"
fi
```

## Testing Strategy

### 1. Local Development
- Use Docker build for architecture testing
- Mount config for rapid iteration
- Test all configuration options

### 2. CI/CD Pipeline
```yaml
# .github/workflows/test.yaml
- name: Test build
  run: |
    docker build \
      --build-arg BUILD_FROM=ghcr.io/home-assistant/amd64-base:latest \
      -t test:latest .
```

### 3. Manual Testing
- Install from local repository
- Test all configuration combinations
- Verify ingress functionality
- Check logs for errors

## Troubleshooting Guide

### Common Issues
1. **Build failures**: Check base image compatibility
2. **Permission errors**: Verify file permissions in Dockerfile
3. **Service won't start**: Check environment variables and paths
4. **Ingress not working**: Verify port configuration and health check

### Debugging Commands
```bash
# Container inspection
docker exec -it addon_container /bin/bash

# Check logs
docker logs addon_container

# Configuration verification
bashio::config | jq '.'
```

## Add-on Lifecycle

### Development
1. Create basic structure
2. Implement core functionality
3. Add configuration options
4. Test locally

### Release
1. Update version in config.yaml
2. Update CHANGELOG.md
3. Create GitHub release
4. CI builds and publishes

### Maintenance
- Monitor for upstream updates
- Security patches via Dependabot
- User feedback integration

## Advanced Features

### Multi-Architecture Support
```yaml
# build.yaml
build_from:
  aarch64: ghcr.io/home-assistant/aarch64-base:latest
  amd64: ghcr.io/home-assistant/amd64-base:latest
  armv7: ghcr.io/home-assistant/armv7-base:latest
```

### Custom UI Integration
```yaml
# config.yaml
ingress: true
panel_iframe: true
panel_icon: mdi:custom-icon
panel_title: "Custom Title"
```

### Data Persistence
```bash
# Ensure data persistence
mkdir -p /data/{config,logs,cache}
chown -R addon:addon /data
```

This guide provides the foundation for creating robust, maintainable Home Assistant add-ons that follow best practices and integrate seamlessly with the Home Assistant ecosystem.
