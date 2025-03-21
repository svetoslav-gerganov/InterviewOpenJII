FROM node:18-alpine

# Set a working directory for the app
WORKDIR /app

# Copy only the package files for dependency installation
COPY package*.json ./

# Install dependencies with caching optimization
RUN --mount=type=cache,target=/root/.npm npm install --production

# Add a non-root user for security
RUN addgroup appgroup && adduser -S appuser -G appgroup

# Copy the rest of the application code
COPY . .

# Set the ownership to the non-root user
RUN chown -R appuser:appgroup /app

# Switch to the non-root user
USER appuser

# Expose the port the app runs on
EXPOSE 3000

# Add a healthcheck to monitor the container's health
HEALTHCHECK  --interval=5m --timeout=3s CMD curl --fail http://localhost:3000/health || exit 1

# Add metadata for container details
LABEL maintainer="svge@brosbook.com"
LABEL version="1.0.0"
LABEL description="Test Node.js App for Interview"

# Command to run the application
CMD ["npm", "start"]