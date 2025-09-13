# Docker for Gemini CLI

[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A ready-to-use and convenient Docker environment for **[Google's Gemini CLI](https://github.com/google-gemini/gemini-cli)** (`@google/gemini-cli`).

[This project](https://github.com/naoyoshinori/docker-gemini-cli) provides Docker images that allow you to use the Gemini CLI without a local Node.js installation. Designed with security and convenience in mind, these images run as a non-root user and offer variants for different use cases, from minimal execution to a full development environment integrated with VS Code Dev Containers.

For detailed documentation on how to use, configure, and contribute to this project, please refer to the **[project documentation](./docs/index.md)**.

## Quick Start

To get started quickly, ensure you have Docker installed and a Gemini API key.

1. **Prerequisites**:

    * [Docker](https://www.docker.com/get-started)
    * [Gemini API Key](https://aistudio.google.com/app/apikey)

2. **Initial Setup**:

    In your **home directory**, create a `.env.gemini` file for your API key and a `.gemini` directory to persist chat history and settings.

    ```bash
    echo "GEMINI_API_KEY=YOUR_API_KEY_HERE" > ~/.env.gemini
    mkdir -p ~/.gemini
    ```

3. **Run Gemini CLI**:

    Execute the following command to start the Gemini CLI. It mounts your current directory and persists your settings and history.

    ```bash
    docker run -it --rm \
      --env-file ~/.env.gemini \
      -v "~/.gemini:/home/node/.gemini" \
      -v "$(pwd):/workspace" \
      -w "/workspace" \
      naoyoshinori/gemini-cli:0.4-node \
      gemini
    ```

    For more detailed instructions and other use cases, see the [**Getting Started Guide**](./docs/getting-started.md).

## Image Variants

This project offers three main image variants to suit different needs. For a comprehensive explanation of each, please refer to the [**Image Variants documentation**](./docs/image-variants.md).

* **`node`**: A minimal image ideal for direct execution and CI/CD.
* **`javascript-node`**: Includes common JavaScript development tools, recommended for VS Code Dev Containers.
* **`typescript-node`**: Adds TypeScript-specific tools for a richer development environment.

## License

* The Google Gemini CLI is licensed under the [Apache 2.0 License](https://github.com/google/generative-ai-go/blob/main/LICENSE).
* The Dockerfile and associated scripts for this project are licensed under the [MIT License](LICENSE).
* As with all Docker images, this image contains other software under other licenses (e.g., the base OS distribution and its dependencies).

## Contributing

Interested in contributing to this project? Please see [**CONTRIBUTING.md**](CONTRIBUTING.md) for details.
