FROM postgres:9.5
MAINTAINER Juanjo Mata <juanjo.mata@gmail.com>

ENV POSTGIS_MAJOR 2.2
ENV POSTGIS_VERSION 2.2.2+dfsg-4.pgdg80+1

RUN apt-get update \
      && apt-get install -y --no-install-recommends \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
           postgis=$POSTGIS_VERSION \
           postgresql-server-dev-$PG_MAJOR \
           postgresql-plpython-$PG_MAJOR \
           ca-certificates \
           build-essential \
           automake \
           git-core \
           git \
      && rm -rf /var/lib/apt/lists/*

# Install latest CartoDB (#FIXME?!) extension
RUN git clone https://github.com/CartoDB/cartodb-postgresql && \
      cd cartodb-postgresql && \
      PGUSER=postgres make install

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./01-initdb-postgis.sh /docker-entrypoint-initdb.d/01_postgis.sh
COPY ./02-initdb-cartodb_pgsql.sh /docker-entrypoint-initdb.d/02_cartodb_pgsql.sh
