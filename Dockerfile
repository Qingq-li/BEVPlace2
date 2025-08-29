FROM anibali/pytorch:1.10.2-cuda11.3

# Avoid interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
# Set PyTorch CUDA memory allocation configuration
ENV PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:128

USER root

# Install system dependencies
RUN apt-get update -y && \
    apt-get install -y build-essential nano libgl1-mesa-glx libglib2.0-0 && \
    apt list --installed && \
    rm -rf /var/lib/apt/lists/*

# Upgrade pip and core Python packaging tools
RUN pip3 install --upgrade pip setuptools wheel

# Create and set working directory
RUN mkdir -p /app
WORKDIR /app
 
# Install PyTorch geometric dependencies
RUN pip3 install --no-cache-dir 'torch-scatter==2.0.9' -f https://data.pyg.org/whl/torch-1.10.2+cu113.html
RUN pip3 install --no-cache-dir 'torch-sparse==0.6.15' -f https://data.pyg.org/whl/torch-1.10.2+cu113.html
RUN pip3 install --no-cache-dir 'torch-geometric==2.1.0.post1'

# Copy and install project-specific requirements
COPY requirements.txt /app/
RUN pip3 install --no-cache-dir -r /app/requirements.txt

# Install essential Python packages
RUN pip3 install --no-cache-dir "numpy<2" pymongo sacred scikit-learn h5py plyfile pyyaml laspy lazrs