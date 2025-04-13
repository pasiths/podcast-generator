FROM ubuntu:latest

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update and install necessary packages
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Ensure pip3 points to the correct version
RUN ln -s /usr/bin/python3.10 /usr/bin/python3 && ln -s /usr/bin/pip3 /usr/bin/pip

# Install Python dependencies
RUN pip install --no-cache-dir PyYAML

# Copy the feed script
COPY feed.py /usr/local/bin/feed.py
RUN chmod +x /usr/local/bin/feed.py

# Copy the entrypoint script and make it executable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["/entrypoint.sh"]
