# Getting Started Guide

This Docker image comes with `@google/gemini-cli` pre-installed.
You don't need to install Node.js or related tools on your local machine; with just Docker, you can immediately try out the functionalities of Gemini CLI.

## Prerequisites

1. Install Docker

    [Docker Official Website](https://www.docker.com/get-started)

2. Create a `.env.gemini` file in your **home directory** and add your **Google Gemini API key** to it.

    **Example:**

    ```bash
    GEMINI_API_KEY=YOUR_API_KEY
    ```

3. Create a directory for user data in your **home directory** to persist Gemini CLI's user-specific data.

    ```bash
    mkdir -p ~/.gemini
    ```

## How to Run

1. To run Gemini CLI, execute the following command:

    ```bash
    docker run -it --rm \
      --env-file ~/.env.gemini \
      -v "~/.gemini:/home/node/.gemini" \
      -v "$(pwd):/workspace" \
      -w "/workspace" \
      naoyoshinori/gemini-cli:0.1-node \
      gemini
    ```

    Success if the container starts and an interactive Gemini CLI prompt is displayed.

## Other Use Cases

For more advanced or specific use cases, please refer to the following guides:

- [**Using Gemini CLI with Docker Run**](./examples/container/README.md)
- [**Using Gemini CLI with Docker Compose**](./examples/docker-compose/README.md)
- [**Using Gemini CLI with VS Code Dev Containers**](./examples/devcontainer/README.md)
- [**Using Gemini CLI with MCP Gateway via Docker Compose**](./examples/mcp-gateway/README.md)
