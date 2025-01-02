# Base image
FROM ubuntu:20.04

# Set non-interactive mode for APT
ENV DEBIAN_FRONTEND=noninteractive

# Install Python 2, Python 3, pip, and system dependencies
RUN apt-get update && apt-get install -y \
    python2 \
    python2-dev \
    python3 \
    python3-pip \
    build-essential \
    gfortran \
    libatlas-base-dev \
    liblapack-dev \
    libblas-dev \
    libfreetype6-dev \
    libpng-dev \
    libxml2-dev \
    libxslt-dev \
    zlib1g-dev \
    r-base \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Install pip for Python 2
RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py --output get-pip.py && \
    python2 get-pip.py && \
    rm get-pip.py

# Copy requirements files (Python 2, Python 3, R)
COPY requirements-python2.txt /app/requirements-python2.txt
COPY requirements-python3.txt /app/requirements-python3.txt
COPY requirements-r.R /app/requirements-r.R

# Install Python 2 dependencies
RUN pip2 install --no-cache-dir -r /app/requirements-python2.txt

# Install Python 3 dependencies
RUN pip3 install --no-cache-dir -r /app/requirements-python3.txt

# Install R dependencies
RUN Rscript /app/requirements-r.R

# Copy the Flask app
COPY app.py /app/app.py

# Set the working directory
WORKDIR /app

# Expose port 8080 for the web server
EXPOSE 8080

# Run the Flask application
CMD ["python3", "app.py"]
