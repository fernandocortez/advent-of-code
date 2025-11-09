FROM mcr.microsoft.com/devcontainers/base:trixie

#
# Install Lua
#
RUN apt-get update && apt-get install -y lua5.4

#
# Install Racket
#
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl xz-utils \
    && rm -rf /var/lib/apt/lists/*
ENV RACKET_VERSION="8.18" \
	RACKET_DOWNLOAD_SHA256="72dfa7602edfe5bd2761af246709ebe93e0fd7f3a0fe98e39bd00418ab7abc70"
RUN set -xe \
	&& RACKET_DOWNLOAD_URL="https://download.racket-lang.org/releases/${RACKET_VERSION}/installers/racket-${RACKET_VERSION}-x86_64-linux-buster-cs.sh" \
	&& curl -fSL -o racket-x86_64-linux-cs.sh $RACKET_DOWNLOAD_URL \
	&& echo "$RACKET_DOWNLOAD_SHA256  racket-x86_64-linux-cs.sh" | sha256sum -c - \
	&& sh racket-x86_64-linux-cs.sh --unix-style --dest /usr/local/racket \
    && rm racket-x86_64-linux-cs.sh
ENV PATH="/usr/local/racket/bin:${PATH}"

#
# Install Go
#
ENV GO_LANG_VERSION="1.25.4" \
	GO_LANG_DOWNLOAD_SHA256="9fa5ffeda4170de60f67f3aa0f824e426421ba724c21e133c1e35d6159ca1bec"
RUN set -xe \
	&& GO_LANG_DOWNLOAD_URL="https://go.dev/dl/go${GO_LANG_VERSION}.linux-amd64.tar.gz" \
	&& curl -fSL -o go.linux-amd64.tar.gz $GO_LANG_DOWNLOAD_URL \
	&& echo "$GO_LANG_DOWNLOAD_SHA256  go.linux-amd64.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf go.linux-amd64.tar.gz \
	&& rm go.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
