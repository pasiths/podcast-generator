FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    python3.10 \
    python3-pip \
    python3-venv \
    git

# Create and activate virtual environment
RUN python3 -m venv /venv
ENV PATH="/venv/bin:$PATH"

# Install PyYAML inside the virtual environment
RUN pip install --no-cache-dir PyYAML

COPY feed.py /usr/local/bin/feed.py

RUN RUN pip3 install --break-system-packages PyYAML

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]