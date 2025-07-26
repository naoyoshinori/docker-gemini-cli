# Using Gemini CLI with VS Code Dev Containers

VS Code Dev Containers allow you to use a Docker container as a full-featured development environment. `devcontainer.json` is the configuration file for this feature.

This is a very simple example of running Gemini CLI using VS Code Dev Containers.

+ **User:** `node` (non-root)
+ **Workdir:** `/workspaces/{your-project-folder-name}` (default for Dev Containers)
+ **Exposed Ports:** None

## Prerequisites

1. Create a `.env.gemini` file in your **home directory** and add your **Google Gemini API key** to it.

    **Example:**

    ```bash
    GEMINI_API_KEY=YOUR_API_KEY
    ```

## How to Run

1. Open this directory in VS Code.
2. You will be prompted to **"Reopen in Container"** or **"Rebuild and Reopen in Container"**. Select one of these options to start the Dev Container environment.
