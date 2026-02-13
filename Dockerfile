FROM node:18-slim

WORKDIR /app

COPY package*.json ./
# Use --legacy-peer-deps to avoid conflicts between React 19 and older react-leaflet-draw
RUN npm install --legacy-peer-deps

COPY . .

# Set environment variables for production build
ENV NODE_OPTIONS=--max-old-space-size=4096
RUN npm run build

RUN npm install -g serve

ENV PORT=8080

EXPOSE 8080

CMD ["serve","-s","build","-l","8080"]