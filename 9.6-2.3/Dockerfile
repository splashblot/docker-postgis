FROM postgres:9.6
MAINTAINER Juanjo Mata <juanjo.mata@gmail.com>

ENV POSTGIS_MAJOR 2.3
ENV POSTGIS_VERSION 2.3.0+dfsg-2.pgdg80+1
ENV CDB_LATEST_VERSION 0.17.1

RUN apt-get update \
      && apt-get install -y --no-install-recommends \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts=$POSTGIS_VERSION \
           postgis=$POSTGIS_VERSION \
           postgresql-server-dev-$PG_MAJOR \
           postgresql-plpython-$PG_MAJOR \
           ca-certificates \
           python-pip \
           python-dev \
           build-essential \
           automake \
           git-core \
           git \
      && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install --upgrade virtualenv

# Install latest CartoDB (#TODO: here?) extension
RUN git clone https://github.com/CartoDB/cartodb-postgresql && \
      cd cartodb-postgresql && \
      git checkout $CDB_LATEST_VERSION  && \
      PGUSER=postgres make install

# Install crankshaft (#TODO: here?) extension
RUN git clone https://github.com/CartoDB/crankshaft && \
      cd crankshaft && \
      git checkout develop && \
      PGUSER=postgres make install

RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./01-initdb-postgis.sh /docker-entrypoint-initdb.d/01_postgis.sh
COPY ./02-initdb-cartodb_pgsql.sh /docker-entrypoint-initdb.d/02_cartodb_pgsql.sh
COPY ./03-initdb-cartodb_crankshaft.sh /docker-entrypoint-initdb.d/03_cartodb_crankshaft.sh
COPY ./04-initdb-metabase.sh /docker-entrypoint-initdb.d/04_metabase.sh
