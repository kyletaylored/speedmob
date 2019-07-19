# Use the official Node.js 10 image.
# https://hub.docker.com/_/node
FROM node:10.13-alpine
ENV NODE_ENV production

# Add metadata
LABEL maintainer="kyletaylored@gmail.com"

# Create and change to the app directory.
WORKDIR /usr/src/app
# Copying this separately prevents re-running npm install on every code change.
COPY ["package.json", "package-lock.json*", "npm-shrinkwrap.json*", "./"]
# Install production dependencies.
RUN npm install --production --silent && mv node_modules ../

# Copy local code to the container image.
COPY . .
# Expose port 3000 for Express server
EXPOSE 3000
# Run the web service on container startup.
CMD npm start