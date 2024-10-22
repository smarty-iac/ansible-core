# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Install Ansible
ARG ANSIBLE_VERSION
RUN pip install ansible==$ANSIBLE_VERSION

# Copy the current directory contents into the container at /app
COPY . /app

# Run a simple command to verify Ansible installation
CMD ["ansible", "--version"]
