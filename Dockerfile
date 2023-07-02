ARG UBUNTU_VERSION=22.04
ARG CONTAINER_PORT=8200

FROM ubuntu:${UBUNTU_VERSION} as build

RUN apt-get update && \
    apt-get install -y build-essential git

WORKDIR /

# Clone ggml repository
RUN git clone https://github.com/ggerganov/llama.cpp

# Set working directory
WORKDIR /llama.cpp

# Build ggml and examples
RUN LLAMA_BUILD_SERVER=1 make

# Now ./server executable created. Pass it into Runtime image

FROM ubuntu:${UBUNTU_VERSION} as runtime

COPY --from=build /llama.cpp/server /usr/local/bin/llamacpp-server
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Set the environment variables
ENV CONTAINER_PORT=${CONTAINER_PORT}
ENV SERVER_HOST=0.0.0.0

WORKDIR /usr/local/bin

RUN chmod +x entrypoint.sh

# Set the entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Expose the specified port
EXPOSE ${CONTAINER_PORT}
