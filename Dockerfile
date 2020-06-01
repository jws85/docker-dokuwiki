FROM ubuntu:focal
Maintainer jwsmith2spam at gmail dot com

# Copy up DokuWiki Apache configuration and Apache run script
COPY dokuwiki.conf /etc/apache2/sites-available/dokuwiki.conf
COPY run-apache.sh /bin/run-apache.sh

# Install DokuWiki, its dependencies, and enable the site in Apache
ARG DUMMY=unknown
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=America/New_York
RUN apt-get -y update \
    && apt-get -y --no-install-recommends install ca-certificates curl apache2 libapache2-mod-php php-xml php-mbstring php-gd tzdata \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled \
    && rm /etc/apache2/sites-enabled/000-default.conf \
    && DUMMY=${DUMMY} curl https://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz | tar xz -C /tmp \
    && mv /tmp/dokuwiki-* /var/www/dokuwiki \
    && chown -R www-data:www-data /var/www/dokuwiki \
    && ln -s /etc/apache2/sites-available/dokuwiki.conf /etc/apache2/sites-enabled/dokuwiki.conf

# Persist the configuration and data files on the host
VOLUME ["/var/www/dokuwiki/conf/", "/var/www/dokuwiki/data/"]

# Run Apache using the script we copied up earlier
ENTRYPOINT bash /bin/run-apache.sh
