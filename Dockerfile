FROM nvidia/cuda:11.6.1-devel-ubuntu20.04

# Copy the current directory contents into the container at /app
WORKDIR /app
COPY requirements.txt /app

# Install any needed packages specified in requirements.txt
RUN apt-get update && apt-get install -y \
    python3-pip \
    && rm -rf /var/lib/apt/lists/* \
    && pip3 install --no-cache-dir -r requirements.txt

# Set the working directory in the container

# Copy the current directory contents into the container at /app
COPY . /app

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable for Hugging Face Cache
ENV TRANSFORMERS_CACHE=/app/model_cache/huggingface_cache

# Set the entrypoint to python3 and the script as part of the entrypoint
ENTRYPOINT ["python3", "run/run_ootd.py"]

# Set the default arguments for the script
CMD ["--model_path", "/workspaces/OOTDiffusion/run/examples/model/01008_00.jpg", "--cloth_path", "/workspaces/OOTDiffusion/run/examples/garment/00055_00.jpg", "--scale", "1.0", "--sample", "1"]
