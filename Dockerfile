# Use an official Python runtime as a parent image
FROM python:3.11-slim
ARG ANSIBLE_VERSION

# Set the working directory in the container
WORKDIR /workplace

# Install Ansible
RUN pip install --upgrade pip
RUN pip install ansible-core==$ANSIBLE_VERSION

# Use user ansible

# Run a simple command to verify Ansible installation
CMD ["ansible", "--version"]
