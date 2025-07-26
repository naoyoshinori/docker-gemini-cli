# Using Gemini CLI with MCP Gateway via Docker Compose

This example demonstrates how to run Gemini CLI alongside an MCP Gateway using Docker Compose.

+ **User:** `node` (non-root)
+ **Workdir:** `/workspace` (for mounting your projects)
+ **Exposed Ports:**
  + `mcp-gateway`: `8811` (exposed to host)

## Prerequisites

1. Docker Desktop (with MCP Toolkit feature enabled)
2. Create a `.env.gemini` file in your **home directory** and add your **Google Gemini API key** to it.

    **Example:**

    ```bash
    GEMINI_API_KEY=YOUR_API_KEY
    ```

3. Ensure the `.gemini/settings.json` file is configured to point to the `mcp-gateway` service. This file is essential for configuring Gemini CLI to use the MCP Gateway in this example.

    **Example:**

    ```json
    {
      "mcpServers": {
        "mcpGateway": {
          "type": "see",
          "url": "http://mcp-gateway:8811"
        }
      }
    }
    ```

4. Enable MCP Toolkit in Docker Desktop settings and add the MCP Server.

    ![Enable MCP Toolkit in Docker Desktop settings and add the MCP Server.](../../assets/docker-desktop-mcp-toolkit.png)

## How to Run

1. Start the Docker Compose services:

    ```bash
    docker-compose up -d
    ```

2. Once the service is running, you can execute **Gemini CLI** with the following command:

    ```bash
    docker-compose exec gemini-cli gemini
    ```

3. From the Gemini CLI prompt, run the following command to list the MCP Servers:

    ```bash
    /mcp list
    ```

    ![Gemini CLI prompt](../../assets/gemini-cli-mcp-list.png)

    If the list of MCP Servers is displayed, the MCP Gateway setup is successful.

    ![MCP Server list result](../../assets/gemini-cli-mcp-list-result.png)

---

## Configuring GitHub Official (Docker MCP Server)

To enable GitHub Official (Docker MCP Server) for seamless integration with GitHub APIs, follow these steps:

1. **Create a Personal Access Token on GitHub:**
    Generate a new fine-grained personal access token in your GitHub settings. This token will be used for authentication.

    ![Create a Personal Access Token](../../assets/github-personal-access-token.png)

2. **Configure the Token in Docker Desktop's MCP Toolkit:**
    Open Docker Desktop, navigate to the MCP Toolkit, select "GitHub Official" from the servers, and set your newly created Personal Access Token in the configuration.

    ![Configure Personal Access Token in Docker Desktop](../../assets/docker-desktop-github-official.png)

Once these steps are completed, you will be able to utilize GitHub Official (Docker MCP Server) through your Gemini CLI setup.
