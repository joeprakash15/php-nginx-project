FROM ubuntu:latest
# Set timezone to UTC
ENV TZ=UTC

# Install packages and set timezone
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && \
    rm -rf /var/lib/apt/lists/*

# Install sudo command
RUN apt-get update && apt-get install -y sudo
# Copy your shell script to the container
COPY my-script.sh /usr/local/bin/

# Make the script executable
RUN chmod +x /usr/local/bin/my-script.sh && /usr/local/bin/my-script.sh

# Run the script
#RUN /usr/local/bin/my-script.sh

# Remove the default Nginx config
RUN rm -f /etc/nginx/sites-available/default

# Copy the custom Nginx config and PHP script
COPY default /etc/nginx/sites-available/

RUN sudo chmod -R 777 /var/www/html
COPY info.php /var/www/html/

# Expose port 80
EXPOSE 80

# Start PHP-FPM and Nginx
CMD service php8.1-fpm start && nginx -g "daemon off;"


