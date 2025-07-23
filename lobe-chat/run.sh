#!/usr/bin/with-contenv bashio

set -e

bashio::log.info "Starting Lobe Chat..."

# Create data directory for persistence
mkdir -p /data

# Set required environment variables
export PORT=3210
export HOSTNAME="0.0.0.0"

# Access control
if ! bashio::config.is_empty 'access_code'; then
    export ACCESS_CODE="$(bashio::config 'access_code')"
fi

# API Keys
if ! bashio::config.is_empty 'openai_api_key'; then
    export OPENAI_API_KEY="$(bashio::config 'openai_api_key')"
fi

if ! bashio::config.is_empty 'openai_api_base_url'; then
    export OPENAI_API_BASE_URL="$(bashio::config 'openai_api_base_url')"
fi

if ! bashio::config.is_empty 'openai_proxy_url'; then
    export OPENAI_PROXY_URL="$(bashio::config 'openai_proxy_url')"
fi

if ! bashio::config.is_empty 'anthropic_api_key'; then
    export ANTHROPIC_API_KEY="$(bashio::config 'anthropic_api_key')"
fi

if ! bashio::config.is_empty 'google_api_key'; then
    export GOOGLE_API_KEY="$(bashio::config 'google_api_key')"
fi

# Model configuration
if ! bashio::config.is_empty 'openai_model_list'; then
    export OPENAI_MODEL_LIST="$(bashio::config 'openai_model_list')"
fi

# Authentication
if bashio::config.true 'enable_oauth_sso'; then
    if ! bashio::config.is_empty 'next_auth_secret'; then
        export NEXT_AUTH_SECRET="$(bashio::config 'next_auth_secret')"
    else
        export NEXT_AUTH_SECRET=$(openssl rand -base64 32)
    fi

    auth_providers=$(bashio::config 'auth_providers')
    if [[ "$auth_providers" != "none" ]]; then
        export AUTH_PROVIDERS="$auth_providers"
    fi
fi

# Feature toggles
if bashio::config.false 'enable_tts'; then
    export NEXT_PUBLIC_ENABLE_TTS=false
fi

if bashio::config.false 'enable_stt'; then
    export NEXT_PUBLIC_ENABLE_STT=false
fi

if bashio::config.false 'enable_artifacts'; then
    export NEXT_PUBLIC_ENABLE_ARTIFACTS=false
fi

# MCP Servers configuration
if ! bashio::config.is_empty 'mcp_servers_config'; then
    export MCP_SERVERS_CONFIG="$(bashio::config 'mcp_servers_config')"
fi

bashio::log.info "Starting Lobe Chat server on port 3210..."

# Change to app directory and start
cd /app
exec npm start
