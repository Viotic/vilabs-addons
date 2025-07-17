# vilabs-prox Home Assistant Add-ons

![Project Stage][project-stage-shield]
![Maintenance][maintenance-shield]

A collection of Home Assistant add-ons for enhanced functionality.

## Installation

Adding this add-ons repository to your Home Assistant instance is pretty simple. In the
Home Assistant add-on store, a possibility to add a repository is provided.

Use the following URL to add this repository:

```txt
https://github.com/your-username/hassio-addons
```

## Add-ons

This repository contains the following add-ons:

### [Open WebUI](./open-webui/README.md)

![Latest Version][openwebui-version-shield]
![Supports armhf Architecture][openwebui-armhf-shield]
![Supports armv7 Architecture][openwebui-armv7-shield]
![Supports aarch64 Architecture][openwebui-aarch64-shield]
![Supports amd64 Architecture][openwebui-amd64-shield]

Open WebUI for Local AI Models - Beautiful chat interface for Ollama and other LLMs

## Support

Got questions?

You have several options to get them answered:

- The Home Assistant [Community Forum][forum].
- Join the [Reddit subreddit][reddit] in [/r/homeassistant][reddit]

You could also [open an issue here][issue] on GitHub.

## Automation

This repository includes comprehensive GitHub Actions workflows for:

- **Continuous Integration** - Automated building and testing
- **Security Scanning** - Daily vulnerability and code quality checks
- **Dependency Management** - Automated updates for base images and dependencies
- **Release Management** - Streamlined version bumping and publishing
- **Documentation** - Automatic shield updates and link validation
- **Upstream Monitoring** - Tracking new releases from source projects

For detailed information about the automation setup, see [AUTOMATION.md](.github/AUTOMATION.md).

## Contributing

This is an active open-source project. We are always open to people who want to
use the code or contribute to it.

Thank you for being involved! 😍

## License

MIT License

Copyright (c) 2025 vilabs-prox

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

[forum]: https://community.home-assistant.io
[issue]: https://github.com/your-username/hassio-addons/issues
[reddit]: https://reddit.com/r/homeassistant
[maintenance-shield]: https://img.shields.io/maintenance/yes/2025.svg
[project-stage-shield]: https://img.shields.io/badge/project%20stage-experimental-yellow.svg
[openwebui-aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[openwebui-amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
[openwebui-armhf-shield]: https://img.shields.io/badge/armhf-no-red.svg
[openwebui-armv7-shield]: https://img.shields.io/badge/armv7-yes-green.svg
[openwebui-version-shield]: https://img.shields.io/badge/version-1.0.0-blue.svg
