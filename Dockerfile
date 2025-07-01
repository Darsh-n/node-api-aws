# Use a minimal, secure base image
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Copy dependency files
COPY package*.json ./

# Install dependencies
RUN npm install --only=production

# Copy the rest of the app
COPY . .

# Set environment variable to production
ENV NODE_ENV=production

# Use non-root user
USER node

# Expose the port your app runs on
EXPOSE 3000

# Start the app
CMD ["node", "index.js"]