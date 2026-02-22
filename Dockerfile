# -------- Stage 1: Build Stage --------
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files first (better caching)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy remaining source code
COPY . .

# If you have build step (like TypeScript)
# RUN npm run build


# -------- Stage 2: Production Stage --------
FROM node:18-alpine

WORKDIR /app

# Copy only required files from builder
COPY --from=builder /app /app


# Set environment
ENV NODE_ENV=production

# Expose port (change if your app uses different port)
EXPOSE 3000

# Start app
CMD ["npm", "start"]