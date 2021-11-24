FROM debian:10-slim

RUN apt-get update && apt-get install -y curl unzip

RUN useradd -m -s /bin/false -u 6737 ngrok

# https://ngrok.com/download
RUN curl -fsSLo /ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip \
 && unzip -o /ngrok.zip -d /bin \
 && rm -f /ngrok.zip

COPY --chown=ngrok ngrok.yml /home/ngrok/.ngrok2/

USER ngrok
