# Docker for Gemini CLI

[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

A ready-to-use and convenient Docker environment for [Google's Gemini CLI](https://github.com/google-gemini/gemini-cli) (`@google/gemini-cli`).

[This project](https://github.com/naoyoshinori/docker-gemini-cli) provides Docker images that let you use the Gemini CLI without installing Node.js on your system. It's designed for security and ease of use, running as a non-root user and offering seamless integration with VS Code Dev Containers. Three main variants are offered to suit different needs: a minimal image for direct execution and two feature-rich images for development.

For detailed documentation on how to use, configure, and contribute to this project, please refer to the [official documentation site](./docs/index.md).

## Quick Start

To get started quickly, ensure you have Docker installed and a Gemini API key.

1. **Prerequisites**:

    * [Docker](https://www.docker.com/get-started)
    * [Gemini API Key](https://aistudio.google.com/app/apikey)

2. **Initial Setup**:

    Create a `.env.gemini` file in your **home directory** with your API key:

    ```bash
    echo "GEMINI_API_KEY=YOUR_API_KEY_HERE" > ~/.env.gemini
    mkdir -p ~/.gemini
    ```

3. **Run Gemini CLI**:

    ```bash
    docker run -it --rm \
      --env-file ~/.env.gemini \
      -v "~/.gemini:/home/node/.gemini" \
      -v "$(pwd):/workspace" \
      -w "/workspace" \
      naoyoshinori/gemini-cli:0.1-node \
      gemini
    ```

    For more detailed instructions, see the [Getting Started Guide](./docs/getting-started.md).

## Image Variants

This image comes in three main variants to suit different use cases:

* **`gemini-cli:<version>-node`**: A minimal image based on Node.js Docker Official Image, ideal for direct execution and CI/CD.
* **`gemini-cli:<version>-javascript-node`**: Based on Microsoft Dev Containers `javascript-node` image, including common JavaScript development tools. Recommended for VS Code Dev Containers.
* **`gemini-cli:<version>-typescript-node`**: Based on Microsoft Dev Containers `typescript-node` image, with additional TypeScript-specific tools. Recommended for VS Code Dev Containers with TypeScript projects.

For a comprehensive explanation of each variant, refer to the [Image Variants documentation](./docs/image-variants.md).

## License

* The Google Gemini CLI is licensed under the [Apache 2.0 License](https://github.com/google/generative-ai-go/blob/main/LICENSE).
* The Dockerfile and associated scripts for this project are licensed under the [MIT License](LICENSE).
* As with all Docker images, this image also contains other software under other licenses (e.g., the base OS distribution and its dependencies).

## Contributing

Interested in contributing to this project? See [CONTRIBUTING.md](CONTRIBUTING.md) for details.
