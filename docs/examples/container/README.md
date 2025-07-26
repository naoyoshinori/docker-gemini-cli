# Using Gemini CLI with Docker Run

This example shows how to use Gemini CLI with the `docker run` command.

+ **User:** `node` (non-root)
+ **Workdir:** `/workspace` (for mounting your projects)
+ **Exposed Ports:** None

## Prerequisites

1. Create a `.env.gemini` file in your **home directory** and add your **Google Gemini API key** to it.

    **Example:**

    ```bash
    GEMINI_API_KEY=YOUR_API_KEY
    ```

2. Create a directory for user data in your **home directory** to persist Gemini CLI's user-specific data.

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
