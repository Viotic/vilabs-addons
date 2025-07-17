ARG BUILD_FROM=ghcr.io/hassio-addons/base-python:18.0.3
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy root filesystem
COPY rootfs /

# Install system dependencies
RUN apk add --no-cache \
    nodejs=20.15.1-r0 \
    npm=10.8.0-r0 \
    git=2.45.2-r0 \
    gcc=13.2.1_git20240309-r0 \
    g++=13.2.1_git20240309-r0 \
    make=4.4.1-r2 \
    python3-dev=3.12.7-r1 \
    libffi-dev=3.4.6-r0 \
    openssl-dev=3.3.2-r0 \
    cargo=1.80.1-r0 \
    rust=1.80.1-r0 \
    curl=8.10.1-r0

# Set work directory
WORKDIR /app

# Clone Open WebUI
RUN git clone https://github.com/open-webui/open-webui.git . \
    && git checkout main

# Install Python dependencies
RUN pip3 install --no-cache-dir -r backend/requirements.txt

# Install Node.js dependencies and build frontend
WORKDIR /app
RUN npm install \
    && npm run build

# Set working directory to backend
WORKDIR /app/backend

# Create data directory
RUN mkdir -p /data

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="vilabs-prox <vilabs-prox@home.local>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="vilabs-prox Home Assistant Add-ons" \
    org.opencontainers.image.authors="vilabs-prox <vilabs-prox@home.local>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://github.com/open-webui/open-webui" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}

# Set environment variables
ENV DATA_DIR=/data
ENV FRONTEND_BUILD_DIR=/app/build
ENV STATIC_DIR=/app/backend/static

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:3000/health || exit 1

# Expose port
EXPOSE 3000

# Define volume
VOLUME ["/data"]
