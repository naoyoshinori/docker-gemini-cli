# Using the Gemini CLI with VS Code Dev Containers

This example demonstrates how to use the Gemini CLI within the VS Code Dev Containers environment.

The container environment is configured as follows:

* **User:** `node` (non-root)
* **Workdir:** `/workspaces/{your-project-folder-name}` (default for Dev Containers)
* **Exposed Ports:** None

## How to Run

1. **Open in VS Code**: Open this project directory in Visual Studio Code.

2. **Reopen in Container**: Select either **"Reopen in Container"** or **"Rebuild and Reopen in Container"** to start the Dev Container environment.

3. **Execute the Gemini CLI**: Once the environment is ready, you can use the `gemini` command directly in the VS Code terminal.

    ```bash
    gemini
    ```

---

[Documentation Home](../../index.md)
