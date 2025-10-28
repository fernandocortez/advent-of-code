FROM mcr.microsoft.com/devcontainers/base:bookworm

#
# Installing various tools
#
# buildpack-deps:bookworm-curl
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		ca-certificates \
		curl \
		gnupg \
		netbase \
		sq \
		wget \
	; \
	rm -rf /var/lib/apt/lists/*
# buildpack-deps:bookworm-scm
RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		git \
		mercurial \
		openssh-client \
		subversion \
		\
		# procps is very common in build systems, and is a reasonably small package
		procps \
	; \
	rm -rf /var/lib/apt/lists/*
# buildpack-deps:bookworm
RUN set -ex; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		autoconf \
		automake \
		bzip2 \
		default-libmysqlclient-dev \
		dpkg-dev \
		file \
		g++ \
		gcc \
		imagemagick \
		libbz2-dev \
		libc6-dev \
		libcurl4-openssl-dev \
		libdb-dev \
		libevent-dev \
		libffi-dev \
		libgdbm-dev \
		libglib2.0-dev \
		libgmp-dev \
		libjpeg-dev \
		libkrb5-dev \
		liblzma-dev \
		libmagickcore-dev \
		libmagickwand-dev \
		libmaxminddb-dev \
		libncurses5-dev \
		libncursesw5-dev \
		libpng-dev \
		libpq-dev \
		libreadline-dev \
		libsqlite3-dev \
		libssl-dev \
		libtool \
		libwebp-dev \
		libxml2-dev \
		libxslt-dev \
		libyaml-dev \
		make \
		patch \
		unzip \
		xz-utils \
		zlib1g-dev \
	; \
	rm -rf /var/lib/apt/lists/*

#
# Install Lua
#
RUN apt-get update && apt-get install -y lua5.4

#
# Install Chez Scheme
#
ENV CHEZ_SCHEME_VERSION="v10.2.0"
RUN set -xe \
	&& CHEZ_SCHEME_DIR="cs${CHEZ_SCHEME_VERSION}" \
	&& CHEZ_SCHEME_DOWNLOAD_URL="https://github.com/cisco/ChezScheme/releases/download/${CHEZ_SCHEME_VERSION}/cs${CHEZ_SCHEME_VERSION}.tar.gz" \
	&& CHEZ_SCHEME_DOWNLOAD_SHA256="b795916d4cfed59240c5f44b1b507a8657efd28e62e72e134d03486e9f3e374a" \
	&& curl -fSL -o chez_scheme.tar.gz $CHEZ_SCHEME_DOWNLOAD_URL \
	&& echo "$CHEZ_SCHEME_DOWNLOAD_SHA256  chez_scheme.tar.gz" | sha256sum -c - \
	&& tar -xzf chez_scheme.tar.gz \
	&& rm chez_scheme.tar.gz \
	&& cd $CHEZ_SCHEME_DIR && ./configure && make && make install \
	&& cd .. && rm -rf $CHEZ_SCHEME_DIR

#
# Install Go
#
ENV GO_LANG_VERSION="1.25.3"
RUN set -xe \
	&& GO_LANG_DOWNLOAD_URL="https://go.dev/dl/go${GO_LANG_VERSION}.linux-amd64.tar.gz" \
	&& GO_LANG_DOWNLOAD_SHA256="0335f314b6e7bfe08c3d0cfaa7c19db961b7b99fb20be62b0a826c992ad14e0f" \
	&& curl -fSL -o go.linux-amd64.tar.gz $GO_LANG_DOWNLOAD_URL \
	&& echo "$GO_LANG_DOWNLOAD_SHA256  go.linux-amd64.tar.gz" | sha256sum -c - \
	&& tar -C /usr/local -xzf go.linux-amd64.tar.gz \
	&& rm go.linux-amd64.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

#
# Install Erlang
#
ENV OTP_VERSION="27.3.4.3"
RUN set -xe \
	&& OTP_DOWNLOAD_URL="https://github.com/erlang/otp/releases/download/OTP-${OTP_VERSION}/otp_src_${OTP_VERSION}.tar.gz" \
	&& OTP_DOWNLOAD_SHA256="597618c75890e8e606033bc8dbf6ec87fdf4e892c10b4912ae3c9a4f01384579" \
	&& runtimeDeps='libodbc1 \
			libsctp1 \
			libwxgtk3.2 \
			libwxgtk-webview3.2-dev  ' \
	&& buildDeps='unixodbc-dev \
			libsctp-dev ' \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends $runtimeDeps \
	&& apt-get install -y --no-install-recommends $buildDeps \
	&& curl -fSL -o otp-src.tar.gz "$OTP_DOWNLOAD_URL" \
	&& echo "$OTP_DOWNLOAD_SHA256  otp-src.tar.gz" | sha256sum -c - \
	&& export ERL_TOP="/usr/src/otp_src_${OTP_VERSION%%@*}" \
	&& mkdir -vp $ERL_TOP \
	&& tar -xzf otp-src.tar.gz -C $ERL_TOP --strip-components=1 \
	&& rm otp-src.tar.gz \
	&& ( cd $ERL_TOP \
	  && ./otp_build autoconf \
	  && gnuArch="$(dpkg-architecture --query DEB_HOST_GNU_TYPE)" \
	  && ./configure --build="$gnuArch" \
	  && make -j$(nproc) \
	  && make -j$(nproc) docs DOC_TARGETS=chunks \
	  && make install install-docs DOC_TARGETS=chunks ) \
	&& find /usr/local -name examples | xargs rm -rf \
	&& apt-get purge -y --auto-remove $buildDeps \
	&& rm -rf $ERL_TOP /var/lib/apt/lists/*

#
# Install Elixir
#
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
