FROM ubuntu:latest

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Only create symlinks if they don't already exist
RUN [ ! -e /usr/bin/python3 ] || rm /usr/bin/python3 && ln -s /usr/bin/python3.10 /usr/bin/python3
RUN [ ! -e /usr/bin/pip ] && ln -s /usr/bin/pip3 /usr/bin/pip || true

# Install Python dependencies
RUN pip install --no-cache-dir PyYAML

# Copy the Python script
COPY feed.py /usr/local/bin/feed.py
RUN chmod +x /usr/local/bin/feed.py

# Copy the entrypoint and make it executable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
