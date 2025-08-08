# Using the Gemini CLI with Docker Compose

This example demonstrates how to run the Gemini CLI using Docker Compose.

The container environment is configured as follows:

* **User:** `node` (non-root)
* **Workdir:** `/workspace` (for mounting your projects)
* **Exposed Ports:** None

## How to Run

1. **Start the service**: From this directory, run the following command to start the service in the background.

    ```bash
    docker-compose up -d
    ```

2. **Execute the Gemini CLI**: Once the service is running, you can execute the Gemini CLI with this command:

    ```bash
    docker-compose exec gemini-cli gemini
    ```

---

[Documentation Home](../../index.md)
