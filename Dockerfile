# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Install Ansible
RUN pip install ansible

# Copy the current directory contents into the container at /app
COPY . /app

# Run a simple command to verify Ansible installation
CMD ["ansible", "--version"]
