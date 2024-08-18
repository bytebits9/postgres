FROM alpine:3.19

LABEL org.opencontainers.image.source="https://github.com/sxbrsky/docker-postgres"
LABEL org.opencontainers.image.title="postgres"
LABEL org.opencontainers.image.base.name="docker.io/library/alpine:3.19"
LABEL org.opencontainers.image.licenses=MIT

ARG POSTGRES_VERSION=17beta2

ENV PGDATA /var/lib/postgresql/data

RUN set -eux; \
    \
      #  add postgres user
        addgroup -g 70 -S postgres; \
        adduser -u 70 -S -D -G postgres -H -h /var/lib/postgresql -s /bin/sh postgres; \
        mkdir -p /var/lib/postgresql; \
        chown -R postgres:postgres /var/lib/postgresql; \
    \
      # install build tools
        apk add --virtual=.build-deps \
          linux-headers \
		  coreutils \
		  dpkg-dev dpkg \
          git \
          clang \
          llvm-dev \
          ninja \
          perl-dev \
          flex \
          bison \
          make \
          libc-dev \
          zlib-dev \
          lz4-dev \
          zstd-dev \
          util-linux-dev \
          meson; \
    \
      # get sources \
        wget -O postgresql.tar.bz2 "https://ftp.postgresql.org/pub/source/v$POSTGRES_VERSION/postgresql-$POSTGRES_VERSION.tar.bz2"; \
        mkdir -p /usr/src/postgres; \
        tar \
		      --extract \
		      --file postgresql.tar.bz2 \
		      --directory /usr/src/postgresql \
		      --strip-components 1 \
		\
		    rm -rf postgresql.tar.bz2; \
        cd /usr/src/postgres; \
    \
      # configure setup \
        export LLVM_CONFIG="/usr/lib/llvm17/bin/llvm-config"; \
        export CLANG=clang; \
        export CC=clang CXX=clang++; \
        meson setup build \
          --buildtype=release \
          --optimization=3 \
          --prefix="/usr/local" \
          -Dnls=disabled \
          -Dplperl=enabled \
          -Dplpython=disabled \
          -Dpltcl=disabled \
          -Dlz4=enabled \
          -Dzstd=enabled \
          -Drpath=false \
          -Dcassert=false \
          -Dgssapi=disabled \
          -Dldap=disabled \
          -Dllvm=enabled \
          -Dsystemd=disabled \
          -Duuid=e2fs \
          -Dtap_tests=disabled \
          -Dextra_lib_dirs=/usr/local/lib \
          -Dsystem_tzdata=/usr/share/zoneinfo; \
        cd build/; \
    \
      # install postgres \
        ninja; \
        ninja install; \
    \
      # install runtime deps
        runDeps="$( \
            scanelf --needed --nobanner --format '%n#p' --recursive /usr/local \
                | tr ',' '\n' \
                | sort -u \
                | awk 'system("[ -e /usr/local/lib/" $1 " ]") == 0 { next } { print "so:" $1 }' \
                | grep -v -e perl \
        )"; \
        apk add --no-cache $runDeps; \
    \
      # clean sources \
        apk del --no-network .build-deps; \
        rm -rf /var/cache/apk/* \
        rm -rf \
            /usr/local/share/doc \
            /usr/local/share/man \
            /usr/src/postgres \
        ; \
    \
      # smoke tests
        postgres --version; \
    \
        mkdir -p /var/run/postgresql; \
        chown -R postgres:postgres /var/run/postgresql; \
        chmod 3777 /var/run/postgresql; \
    \
        mkdir -p "$PGDATA"; \
        chown -R postgres:postgres "$PGDATA"; \
        chmod 1700 "$PGDATA"; \
    \
      cp -v /usr/local/share/postgresql/postgresql.conf.sample /var/lib/postgresql/data/postgresql.conf
VOLUME /var/lib/postgresql/data

STOPSIGNAL SIGINT

USER postgres

EXPOSE 5432
CMD ["postgres"]
