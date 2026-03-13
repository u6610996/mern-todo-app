# Stage 1: Build frontend
FROM node:18-alpine AS frontend-builder

WORKDIR /app/todo_frontend

COPY TODO/todo_frontend/package*.json ./
RUN npm install

COPY TODO/todo_frontend/ ./
RUN npm run build

# Stage 2: Setup backend
FROM node:18-alpine

WORKDIR /app

COPY TODO/todo_backend/package*.json ./
RUN npm install --production

COPY TODO/todo_backend/ ./

RUN mkdir -p ./static
COPY --from=frontend-builder /app/todo_frontend/build ./static/build

EXPOSE 5000

ENV PORT=5000

CMD ["node", "server.js"]