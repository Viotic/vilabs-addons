ARG BUILD_FROM
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy root filesystem
COPY rootfs /

# Install system dependencies including additional libs for opencv
RUN apk add --no-cache \
    nodejs \
    npm \
    git \
    gcc \
    g++ \
    make \
    python3-dev \
    libffi-dev \
    openssl-dev \
    curl \
    bash \
    cmake \
    pkgconfig \
    linux-headers \
    jpeg-dev \
    zlib-dev \
    libjpeg \
    libpng-dev \
    tiff-dev \
    libwebp-dev \
    openblas-dev \
    && pip3 install --no-cache-dir --upgrade pip "setuptools>=70.1" wheel

# Set work directory
WORKDIR /app

# Create app directory structure
RUN mkdir -p /app /data

# Install Open WebUI via pip (compatible with Python 3.12)
# Strategy: Try different approaches in order of preference
RUN pip3 install --no-cache-dir --only-binary=:all: open-webui || \
    (echo "Trying with specific opencv version..." && \
     pip3 install --no-cache-dir --only-binary=:all: "opencv-python-headless<4.9" && \
     pip3 install --no-cache-dir --only-binary=:all: open-webui) || \
    (echo "Upgrading setuptools and trying compilation..." && \
     pip3 install --no-cache-dir --upgrade "setuptools>=70.1" wheel && \
     pip3 install --no-cache-dir --no-binary=opencv-python,opencv-python-headless open-webui)

# Build arguments (required for Home Assistant add-ons)
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
ENV PORT=3000
ENV HOST=0.0.0.0

# Health check - check if the service is responding
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:3000/ || exit 1

# Expose port
EXPOSE 3000

# Define volume
VOLUME ["/data"]
