FROM mcr.microsoft.com/devcontainers/base:bookworm

# Install Erlang
ENV ERLANG_VERSION="27.3.4-1"
RUN apt-get update && apt-get install -y libsctp1 libncurses6
RUN set -xe \
	&& ERLANG_OTP_DOWNLOAD_URL="https://binaries2.erlang-solutions.com/debian/pool/contrib/e/esl-erlang/esl-erlang_${ERLANG_VERSION}~debian~bookworm_amd64.deb" \
	&& curl -fSL -o erlang~debian~bookworm_amd64.deb $ERLANG_OTP_DOWNLOAD_URL \
    && dpkg -i ./erlang~debian~bookworm_amd64.deb \
	&& rm erlang~debian~bookworm_amd64.deb

# Install Elixir
ENV ELIXIR_VERSION="v1.19.1" \
	LANG=C.UTF-8
RUN set -xe \
	&& ELIXIR_DOWNLOAD_URL="https://github.com/elixir-lang/elixir/archive/${ELIXIR_VERSION}.tar.gz" \
	&& ELIXIR_DOWNLOAD_SHA256="4dfbfa2d0863bb3809109757a599b453e78ea890f31fa54456a2d81b40bc930f" \
	&& curl -fSL -o elixir-src.tar.gz $ELIXIR_DOWNLOAD_URL \
	&& echo "$ELIXIR_DOWNLOAD_SHA256  elixir-src.tar.gz" | sha256sum -c - \
	&& mkdir -p /usr/local/src/elixir \
	&& tar -xzC /usr/local/src/elixir --strip-components=1 -f elixir-src.tar.gz \
	&& rm elixir-src.tar.gz \
	&& cd /usr/local/src/elixir \
	&& make install clean \
	&& find /usr/local/src/elixir/ -type f -not -regex "/usr/local/src/elixir/lib/[^\/]*/lib.*" -exec rm -rf {} + \
	&& find /usr/local/src/elixir/ -type d -depth -empty -delete

# Install Lua
RUN apt-get update && apt-get install -y lua5.4

# Install Go
ENV GO_LANG_VERSION="1.25.3"
RUN set -xe \
	&& GO_LANG_DOWNLOAD_URL="https://go.dev/dl/go${GO_LANG_VERSION}.linux-amd64.tar.gz" \
	&& GO_LANG_DOWNLOAD_SHA256="0335f314b6e7bfe08c3d0cfaa7c19db961b7b99fb20be62b0a826c992ad14e0f" \
	&& curl -fSL -o go.linux-amd64.tar.gz $GO_LANG_DOWNLOAD_URL \
	&& echo "$GO_LANG_DOWNLOAD_SHA256  go.linux-amd64.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf go.linux-amd64.tar.gz \
	&& rm go.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin
