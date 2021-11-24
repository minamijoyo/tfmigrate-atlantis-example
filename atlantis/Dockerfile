FROM runatlantis/atlantis:v0.17.5

# Install jq for parse JSON in custom scripts
RUN apk add --no-cache jq

# Install tfmigrate
ENV TFMIGRATE_VERSION 0.2.11
RUN curl -fsSL https://github.com/minamijoyo/tfmigrate/releases/download/v${TFMIGRATE_VERSION}/tfmigrate_${TFMIGRATE_VERSION}_linux_amd64.tar.gz \
  | tar -xzC /usr/local/bin && chmod +x /usr/local/bin/tfmigrate

# Create a mount point for data-dir in Atlantis configuration
RUN mkdir -p /var/lib/atlantis && chown atlantis:atlantis /var/lib/atlantis

# Copy configuration
RUN mkdir -p /etc/atlantis
COPY . /etc/atlantis/

# Add custom scripts to $PATH
ENV PATH $PATH:/etc/atlantis/hooks/
