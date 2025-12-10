# Use an official Python runtime as a parent image
FROM python:3.13-slim
ARG ANSIBLE_VERSION

# Set the working directory in the container
WORKDIR /workplace

# Install Ansible
RUN apt-get update
RUN apt-get -y install less openssh-client netavark
RUN pip install --upgrade pip
RUN pip install boto3
RUN pip install ansible-core==$ANSIBLE_VERSION


# Use user ansible

# Run a simple command to verify Ansible installation
CMD ["ansible", "--version"]
