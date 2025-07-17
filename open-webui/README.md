# Home Assistant Add-on: Open WebUI

![Project Stage][project-stage-shield]
![Maintenance][maintenance-shield]
![Awesome][awesome-shield]

Open WebUI for Local AI Models - Beautiful chat interface for Ollama and other LLMs

## About

This add-on brings Open WebUI to your Home Assistant environment, providing a beautiful and intuitive web interface for interacting with your local AI models. Perfect for integrating Ollama models with your smart home setup.

![Open WebUI Screenshot](https://raw.githubusercontent.com/open-webui/open-webui/main/demo.gif)

## Features

- 🎯 **Home Assistant Integration**: Seamlessly integrated with Home Assistant OS
- 🤖 **Ollama Support**: Direct integration with local Ollama models
- 🌐 **Multiple Providers**: Support for OpenAI, Anthropic, and other API providers
- 🎨 **Beautiful Interface**: Modern, responsive chat interface
- 🔒 **Privacy First**: All data stays on your local network
- 📱 **Mobile Friendly**: Works great on all devices
- 🔧 **Highly Configurable**: Extensive customization options

## Installation

1. Add this repository to your Home Assistant add-on store:
   ```
   https://github.com/your-username/hassio-addons
   ```
2. Install the "Open WebUI" add-on
3. Configure your settings (especially the Ollama URL if using Ollama)
4. Start the add-on
5. **Access through the Home Assistant interface** - The add-on will appear in your sidebar for easy access!

## Show in Sidebar

This add-on is configured with **ingress support**, which means:
- ✅ **Direct sidebar access** - No need to remember ports or URLs
- ✅ **Seamless integration** - Works within the Home Assistant interface
- ✅ **Single sign-on** - Uses your Home Assistant authentication
- ✅ **Mobile-friendly** - Perfect tablet and mobile experience

Once installed and started, you'll see "Open WebUI" in your Home Assistant sidebar!

## Configuration

Example configuration:

```yaml
log_level: info
ollama_base_url: "http://supervisor:11434"
enable_signup: true
enable_web_search: false
```

## Quick Start with Ollama

1. Install the Ollama add-on from the Home Assistant add-on store
2. Install this Open WebUI add-on
3. Configure Open WebUI to point to Ollama: `http://supervisor:11434`
4. Start both add-ons
5. Access Open WebUI and start chatting!

## Support

For support and questions:

- 📖 [Documentation](DOCS.md)
- 💬 [Home Assistant Community](https://community.home-assistant.io/)
- 🐛 [Issue Tracker](https://github.com/open-webui/open-webui/issues)

## License

MIT License - see [LICENSE](https://github.com/open-webui/open-webui/blob/main/LICENSE) for details.

[awesome-shield]: https://img.shields.io/badge/awesome%3F-yes-brightgreen.svg
[maintenance-shield]: https://img.shields.io/maintenance/yes/2025.svg
[project-stage-shield]: https://img.shields.io/badge/project%20stage-experimental-yellow.svg
