# Base image
FROM ubuntu:20.04

# Set non-interactive mode for APT
ENV DEBIAN_FRONTEND=noninteractive

# Step 1: Install Python 2, Python 3, pip, and system dependencies
RUN apt-get update && apt-get install -y \
    software-properties-common \
    python2 \
    python3 \
    python3-pip \
    wget \
    curl \
    gnupg \
    build-essential \
    libcurl4-gnutls-dev \
    libxml2-dev \
    libssl-dev \
    && rm -rf /var/lib/apt/lists/*

# Step 2: Install pip for Python 2
RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py && \
    python2 get-pip.py && \
    rm get-pip.py

# Step 3: Install R
RUN apt-get update && apt-get install -y r-base && rm -rf /var/lib/apt/lists/*

# Step 4: Install dependencies for Python 2, Python 3, and R
COPY requirements-python2.txt /app/requirements-python2.txt
COPY requirements-python3.txt /app/requirements-python3.txt
COPY requirements-r.R /app/requirements-r.R

# Install Python 2 dependencies
RUN pip2 install -r /app/requirements-python2.txt

# Install Python 3 dependencies
RUN pip3 install -r /app/requirements-python3.txt

# Install R dependencies
RUN Rscript /app/requirements-r.R

# Step 5: Copy the hello-world script for Python 2, Python 3, and R
COPY hello-world.sh /app/hello-world.sh

# Set work directory
WORKDIR /app

# Copy app
COPY app.py /app/app.py

# Expose port
EXPOSE 8080

# Run flask app
CMD ["python3", "app.py"]

