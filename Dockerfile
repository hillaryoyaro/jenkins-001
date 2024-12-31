FROM jenkins/jenkins:2.426.1

USER root

# Install required packages
RUN apt-get update && apt-get install -y \
    apt-utils \
    lsb-release \
    python3-pip \
    curl

# Add Docker GPG key and repository
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
    https://download.docker.com/linux/debian/gpg && \
    echo "deb [arch=$(dpkg --print-architecture) \
    signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
    https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

# Install Docker CLI
RUN apt-get update && apt-get install -y docker-ce-cli

# Switch back to Jenkins user
USER jenkins

# Install Jenkins plugins
RUN jenkins-plugin-cli --plugins "blueocean:1.25.3 docker-workflow:1.28"
