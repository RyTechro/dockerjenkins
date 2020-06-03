FROM jenkins/jenkins:lts

USER root

RUN apt-get clean
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y apt-utils
RUN apt-get install -y ca-certificates apt-transport-https
RUN wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -
RUN echo "deb https://packages.sury.org/php/ stretch main" | tee /etc/apt/sources.list.d/php.list
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y libc6
RUN apt-get install -y php7.3-fpm php7.3 php7.3-common php7.3-cli php7.3-readline php7.3-opcache php7.3-mysql php7.3-xml php7.3-curl php7.3-zip
RUN apt-get install -y php7.3-intl php7.3-mbstring php7.3-pdo-sqlite 
RUN apt-get install -y php7.3-xdebug php7.3-soap php7.3-pcov
RUN apt-get install -y php7.3-gd
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs
RUN apt-get update && apt-get upgrade -y

RUN echo "deb https://packages.sury.org/php/ buster main" | tee /etc/apt/sources.list.d/php.list

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


RUN npm config set unsafe-perm true && \
	npm install -g sonarqube-scanner

USER jenkins

RUN sonar-scanner --version



# Install composer packages
RUN composer global config minimum-stability dev; \
	composer global config prefer-stable true; \
	composer global require phpunit/phpunit  --prefer-source --no-interaction

#squizlabs/php_codesniffer phploc/phploc pdepend/pdepend phpmd/phpmd sebastian/phpcpd theseer/phpdox:dev-master

# Cleanup
USER jenkins