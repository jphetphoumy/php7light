from alpine:3.8 as builder
LABEL maintainer="j.phetphoumy@gmail.com"

ARG BUILD_DATE

LABEL org.label-schema.name="php7Light"
LABEL org.label-schema.description="A Php7 Light container image"
LABEL org.label-schema.build_date=$BUILD_DATE
LABEL org.label-schema.schema-version="1.0"

RUN apk add --no-cache php7 \
                       php7-openssl \
                       php7-json \
                       php7-phar \
                       php7-iconv \
                       php7-xmlwriter \
                       php7-dom \
                       php7-tokenizer \
                       php7-mbstring \
                       php7-xml

# Download and install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"

# Check validity of the file
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '93b54496392c062774670ac18b134c3b3a95e5a5e5c8f1a9f115f203b75bf9a129d5daa8ba6a13e2cc8a1da0806388a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"

# Run composer setup 
RUN php composer-setup.php --install-dir=bin --filename=composer
