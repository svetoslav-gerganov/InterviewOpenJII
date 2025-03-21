## Application Overview

The application is a simple Express.js server that:

- Responds with a greeting message on the root path
- Provides a health check endpoint at `/health`
- Runs on port 3000 by default (configurable via the PORT environment variable)

## Dockerfile

- The WORKDIR command sets the working directory for subsequent instructions in the Dockerfile. This is where the application code will be placed.
- The COPY command copies package.json and package-lock.json (if available) into the /app directory to install dependencies.
- This RUN command installs dependencies only for production, with caching for faster builds on subsequent runs.
- A non-root user is created (appuser) along with a group (appgroup) for security purposes. Running containers as a non-root user helps reduce security risks.
- Copy command copies the rest of the application code into the container. 
- Ensures that all the files in the /app directory are owned by the non-root user (appuser).
- Switches the active user to appuser, ensuring the application runs with restricted permissions.
- Exposes port 3000, as application is running on this port by config.
- Health check ensures that the container is running by making an HTTP request to /health on the application. If the request fails, the container will be marked as unhealthy.
- Adds metadata for the container with the maintainer's email, version, and a short description of the application.
- Specifies the command to start the Node.js application when the container is run. The npm start command is executed to run the app.

