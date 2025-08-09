# Docker for Gemini CLI

Welcome! This site provides documentation and Docker images for running the **[Gemini CLI (`@google/gemini-cli`)](https://github.com/google-gemini/gemini-cli)**.

Using these pre-configured images allows you to run the Gemini CLI without needing to set up a local Node.js environment. All images for this project are available on [Docker Hub](https://hub.docker.com/r/naoyoshinori/gemini-cli).

For details on the CLI's features and commands, please refer to the [official Gemini CLI documentation](https://github.com/google-gemini/gemini-cli/blob/main/docs/index.md).

## User Guide

* [**Getting Started**](./getting-started.md)
  * Learn the basic setup and how to run the CLI with `docker run`.
* [**Image Variants**](./image-variants.md)
  * Understand the differences between the image variants (`node`, `javascript-node`, `typescript-node`) and choose the right one for your needs.

## Examples

* [**Using with Docker Compose**](./examples/docker-compose/)
  * Run the Gemini CLI as a persistent service using Docker Compose.
* [**Using with VS Code Dev Containers**](./examples/devcontainer/)
  * Integrate the Gemini CLI directly into your VS Code development workflow.
* [**Using with an MCP Gateway**](./examples/mcp-gateway/)
  * Connect the Gemini CLI to external tools via the MCP Gateway.

## For Developers

This section contains information for those who wish to contribute to this project or customize the images.

* [**Contribution Guide**](https://github.com/naoyoshinori/docker-gemini-cli/blob/main/CONTRIBUTING.md)
  * Explains how to set up the development environment and the procedures for building and releasing.
