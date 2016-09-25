FROM xaamin/ubuntu:16.04
MAINTAINER Benjamín Martínez Mateos <xaamin@outlook.com>

# Install PHP7 AND popular required extensions
RUN apt-get -y update \
	&& DEBIAN_FRONTEND=noninteractive apt-get -y install \
        php7.0-cli \ 
        php7.0-bz2 \
        php7.0-common \
        php7.0-curl \
        php7.0-gd \
        php7.0-gmp \
        php7.0-imap \
        php7.0-intl \
        php7.0-ldap \
    	php7.0-json \
        php7.0-mbstring \
        php7.0-mcrypt \
        php7.0-mysql \
        php7.0-opcache \
        php7.0-pgsql \
        php7.0-ps \
    	php7.0-readline \
        php7.0-sybase \
        php7.0-soap \
        php7.0-sqlite3 \
        php7.0-tidy \  
        php7.0-xml \   
        php7.0-xmlrpc \
        php7.0-xsl \
        php7.0-zip \

        php-geoip \
        php-imagick \
        php-memcached \
        php-mongodb \
        php-redis \
        php-xdebug \

	# Remove temp files
	&& apt-get clean \
    && apt-get -y autoremove \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && sed -i 's|;\?date.timezone =.*|date.timezone = ${DATE_TIMEZONE}|' /etc/php/7.0/cli/php.ini

# Defines the default timezone used by the date functions
ENV DATE_TIMEZONE America/Mexico_City

# Set composer home
ENV COMPOSER_HOME /root/composer

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Install phpunit and put binary into $PATH
RUN curl -sSLo phpunit.phar https://phar.phpunit.de/phpunit.phar \
    && chmod 755 phpunit.phar \
    && mv phpunit.phar /usr/local/bin/phpunit

# Enable modules
RUN phpenmod gmp iconv mcrypt mongodb pdo pgsql sqlite3 readline redis xml xsl

# Default command
CMD ["/usr/bin/php", "-a"]