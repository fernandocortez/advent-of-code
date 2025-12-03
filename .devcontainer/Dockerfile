FROM mcr.microsoft.com/devcontainers/javascript-node:24-trixie

#
# Install Lua
#
RUN apt-get update && apt-get install -y lua5.4

#
# Install Racket
#
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		libcairo2 \
		libfontconfig1 \
		libglib2.0-dev \
		libjpeg62-turbo-dev \
		libpango-1.0-0 \
		libpangocairo-1.0-0 \
	; \
	rm -rf /var/lib/apt/lists/*
ENV RACKET_VERSION="8.18" \
	RACKET_DOWNLOAD_SHA256="72dfa7602edfe5bd2761af246709ebe93e0fd7f3a0fe98e39bd00418ab7abc70"
RUN set -xe \
	&& RACKET_DOWNLOAD_URL="https://download.racket-lang.org/releases/${RACKET_VERSION}/installers/racket-${RACKET_VERSION}-x86_64-linux-buster-cs.sh" \
	&& curl -fSL -o racket-x86_64-linux-cs.sh $RACKET_DOWNLOAD_URL \
	&& echo "$RACKET_DOWNLOAD_SHA256  racket-x86_64-linux-cs.sh" | sha256sum -c - \
	&& sh racket-x86_64-linux-cs.sh --unix-style --dest /usr/local/racket \
    && rm racket-x86_64-linux-cs.sh
ENV PATH="/usr/local/racket/bin:${PATH}"
