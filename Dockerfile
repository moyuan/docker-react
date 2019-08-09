# Multi-step builds
# Step 1: build the production js file
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Step 2: copy prod js file to nginx and start nginx
FROM nginx
COPY --from=builder /app/build /usr/share/nginx/html

# default command of nginx image is to start nginx service