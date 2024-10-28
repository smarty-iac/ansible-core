# Use an official Python runtime as a parent image
FROM python:3.11-slim
ARG ANSIBLE_VERSION

# Set the working directory in the container
RUN useradd -d /workdir -m -s /bin/bash ansible
WORKDIR /workdir

# Install Ansible
RUN pip install ansible-core==$ANSIBLE_VERSION
RUN useradd -d /workdir -m -s /bin/bash ansible

# Use user ansible
USER ansible

# Run a simple command to verify Ansible installation
CMD ["ansible", "--version"]
