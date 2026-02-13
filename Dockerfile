FROM node:18-slim

WORKDIR /app

COPY package*.json ./
# Clean install and force specific ajv versions to resolve webpack/react-scripts issues
RUN npm install --legacy-peer-deps && \
    npm install ajv@^8.12.0 ajv-keywords@^5.1.0 --save-exact --legacy-peer-deps

COPY . .

# Set environment variables for production build
# CI=false prevents warnings from being treated as errors during build
ENV CI=false
ENV NODE_OPTIONS=--max-old-space-size=4096

RUN npm run build

RUN npm install -g serve

ENV PORT=8080

EXPOSE 8080

CMD ["serve","-s","build","-l","8080"]