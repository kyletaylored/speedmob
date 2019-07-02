# Use the official Node.js 10 image.
# https://hub.docker.com/_/node
FROM node:10

# Create and change to the app directory.
WORKDIR /usr/src/app/web

# Copy application dependency manifests to the container image.
# A wildcard is used to ensure both package.json AND package-lock.json are copied.
# Copying this separately prevents re-running npm install on every code change.
COPY node/package*.json ./

# Install production dependencies.
RUN npm install --only=production

# Copy local code to the container image.
COPY ./node .

# Run the web service on container startup.
CMD [ "npm", "start" ]