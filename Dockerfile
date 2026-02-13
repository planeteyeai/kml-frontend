FROM node:18-slim

WORKDIR /app

COPY package*.json ./
# Install dependencies - legacy-peer-deps helps with version conflicts
RUN npm install --legacy-peer-deps

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