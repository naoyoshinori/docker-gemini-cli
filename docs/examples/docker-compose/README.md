# Using Gemini CLI with Docker Compose

This is a very simple example of running Gemini CLI using Docker Compose.

+ **User:** `node` (non-root)
+ **Workdir:** `/workspace` (for mounting your projects)
+ **Exposed Ports:** None

## Prerequisites

1. Create a `.env.gemini` file in your **home directory** and add your **Google Gemini API key** to it.

    **Example:**

    ```bash
    GEMINI_API_KEY=YOUR_API_KEY
    ```

## How to Run

1. Start the Docker Compose services:

    ```bash
    docker-compose up -d
    ```

2. Once the service is running, you can execute **Gemini CLI** with the following command:

    ```bash
    docker-compose exec gemini-cli gemini
    ```
