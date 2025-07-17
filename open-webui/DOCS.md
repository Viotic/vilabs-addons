# Home Assistant Add-on: Open WebUI

A beautiful and modern web interface for interacting with your local AI models
through Ollama and other LLM providers.

![Open WebUI Logo][logo]

## About

Open WebUI is a user-friendly, feature-rich, and highly customizable web interface
designed to operate entirely offline. It supports various LLM runners including
Ollama and OpenAI-compatible APIs.

Key features include:

- 🚀 **Intuitive Interface**: Chat-like interface for seamless conversations
- 🔄 **Multiple Model Support**: Works with Ollama, OpenAI, and other compatible APIs
- 🎨 **Customizable**: Themes, prompts, and interface customization
- 📱 **Responsive Design**: Works great on desktop and mobile devices
- 🔒 **Privacy-First**: All conversations stay on your local network
- 🔧 **Advanced Features**: Model management, conversation history, and more

## Installation

1. Navigate to the Home Assistant Add-on Store
2. Add this repository URL: `https://github.com/Viotic/vilabs-addons`
3. Install the "Open WebUI" add-on
4. Configure the add-on settings
5. Start the add-on
6. **Access via sidebar** - Open WebUI will appear in your Home Assistant
   sidebar!

## Sidebar Integration

This add-on features **seamless Home Assistant integration**:

- 🔗 **Direct Sidebar Access**: After installation, find "Open WebUI" in your left sidebar
- 🔐 **Integrated Authentication**: Uses Home Assistant's built-in security
- 📱 **Mobile Optimized**: Perfect experience on tablets and phones
- 🚀 **No External URLs**: Everything works within your Home Assistant interface

Simply start the add-on and click "Open WebUI" in your sidebar to begin chatting with your AI models!

## Configuration

Add-on configuration:

```yaml
log_level: info
ollama_base_url: "http://supervisor:11434"
webui_secret_key: ""
default_models: ""
enable_signup: true
enable_login_form: true
enable_web_search: false
web_search_engine: "duckduckgo"
enable_image_generation: false
automatic_1111_base_url: ""
comfyui_base_url: ""
openai_api_base_url: ""
openai_api_key: ""
enable_model_filter: false
model_filter_list: ""
```

### Option: `log_level`

The log level for the add-on. Can be `trace`, `debug`, `info`, `notice`,
`warning`, `error`, or `fatal`.

### Option: `ollama_base_url`

The base URL for your Ollama instance. If running Ollama as another Home Assistant
add-on, use `http://supervisor:11434`.

### Option: `webui_secret_key`

Secret key used for session management. If left empty, a random key will be
generated automatically.

### Option: `default_models`

Comma-separated list of default models to load on startup.

### Option: `enable_signup`

Allow new users to sign up. Set to `false` to disable user registration.

### Option: `enable_login_form`

Show the login form on the interface. Set to `false` to hide it.

### Option: `enable_web_search`

Enable web search functionality in conversations.

### Option: `web_search_engine`

The search engine to use for web searches. Options: `duckduckgo`, `google`,
`brave`, `searxng`.

### Option: `enable_image_generation`

Enable image generation features.

### Option: `automatic_1111_base_url`

Base URL for Automatic1111 Stable Diffusion instance for image generation.

### Option: `comfyui_base_url`

Base URL for ComfyUI instance for image generation.

### Option: `openai_api_base_url`

Base URL for OpenAI-compatible API endpoints.

### Option: `openai_api_key`

API key for OpenAI or compatible services.

### Option: `enable_model_filter`

Enable filtering of available models.

### Option: `model_filter_list`

Comma-separated list of models to show when filtering is enabled.

## Integration with Ollama

To use this add-on with Ollama:

1. Install and configure the Ollama add-on in Home Assistant
2. Set the `ollama_base_url` to `http://supervisor:11434`
3. Start both add-ons
4. Access Open WebUI through the Home Assistant interface
5. Your Ollama models will be automatically detected

## Usage

1. Start the add-on
2. Open the web interface through Home Assistant's ingress feature
3. Create an account or log in
4. Start chatting with your AI models!

## Support

Got questions? Check out:

- [Open WebUI Documentation](https://docs.openwebui.com/)
- [Home Assistant Community Forum](https://community.home-assistant.io/)
- [GitHub Issues](https://github.com/open-webui/open-webui/issues)

## Authors & Contributors

This add-on is based on the excellent [Open WebUI](https://github.com/open-webui/open-webui) project.

Add-on created for vilabs-prox Home Assistant integration.

[logo]: https://raw.githubusercontent.com/open-webui/open-webui/main/static/favicon.png
