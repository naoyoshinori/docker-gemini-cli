# Getting Started Guide

This guide explains the basic steps to get started with the Gemini CLI using Docker. This Docker image comes with `@google/gemini-cli` pre-installed, so you don't need to install Node.js on your local machine.

## 1. Prerequisites

Before you begin, make sure you have the following:

* **Docker**: Installed on your system. You can get it from the [Docker Official Website](https://www.docker.com/get-started).
* **Google Gemini API Key**: Required to use the Gemini models. You can obtain one from [Google AI Studio](https://aistudio.google.com/app/apikey).

## 2. Initial Setup

Prepare a configuration file for your API key and a directory to persist user data.

* **Create the `.env.gemini` file**: In your **home directory**, create a file named `.env.gemini`. Add the following line to the file, replacing `YOUR_API_KEY_HERE` with your actual key.

    ```bash
    GEMINI_API_KEY=YOUR_API_KEY_HERE
    ```

* **Create `.gemini` directory**: This directory saves your chat history and settings outside the container. Create it in your **home directory**.

    ```bash
    mkdir -p ~/.gemini
    ```

## 3. How to Run

Execute the following command to start the Gemini CLI. This command creates a container environment with the following characteristics:

* **User:** `node` (non-root)
* **Workdir:** `/workspace` (for mounting your projects)
* **Exposed Ports:** None

```bash
docker run -it --rm \
  --env-file ~/.env.gemini \
  -v "~/.gemini:/home/node/.gemini" \
  -v "$(pwd):/workspace" \
  -w "/workspace" \
  naoyoshinori/gemini-cli:0.1-node \
  gemini
```

*Note: Please check [Docker Hub](https://hub.docker.com/r/naoyoshinori/gemini-cli/tags) for the latest available image tags.*

If successful, the container will start, and you will see an interactive Gemini CLI prompt.

## 4. Examples

For more advanced scenarios, you can refer to the following examples:

* [Using Gemini CLI with Docker Compose](./examples/docker-compose/)
* [Using Gemini CLI with VS Code Dev Containers](./examples/devcontainer/)
* [Using Gemini CLI with MCP Gateway via Docker Compose](./examples/mcp-gateway/)
