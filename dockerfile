# Use the official Nginx image from the Docker Hub
FROM nginx:latest

# Copy the content of the current directory to /usr/share/nginx/html
COPY . /usr/share/nginx/html

# Copy your custom Nginx configuration file
COPY default.conf /etc/nginx/conf.d/default.conf

# Expose port 80 to the outside world
EXPOSE 80

# Start Nginx when the container has started
CMD ["nginx", "-g", "daemon off;"]
