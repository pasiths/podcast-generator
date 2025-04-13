FROM ubuntu:latest

# Avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update and install required packages
# Install Python and pip
RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    git \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

# Ensure 'pip' is available (symlink to pip3)
RUN ln -sf /usr/bin/pip3 /usr/bin/pip

# Install dependencies
RUN pip install --no-cache-dir PyYAML

# Copy the Python script
COPY feed.py /usr/local/bin/feed.py
RUN chmod +x /usr/local/bin/feed.py

# Copy the entrypoint and make it executable
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
