FROM ruby:2.7-alpine
# ruby 镜像预设的这个环境变量干扰了后面的操作，将它重置为默认值
ENV BUNDLE_APP_CONFIG=.bundle

RUN set -xe; \
    apk add --no-cache --update --virtual .runtime-deps \
        mariadb-connector-c \
        bash \
        nodejs \
        npm \
        sqlite-libs \
        tzdata;
# 如果需要安装其他依赖，取消这段注释
# RUN apt-get update && apt-get install -y --no-install-recommends \
#   nodejs \
#   npm \
#   postgresql-client
RUN gem install bundler --user-install \
    gem update\
    gem install rake -v 13.0.1\
    bundle config set no-cach 'true'\
    bundle install

ENV MARIADB_HOST="mariadb" \
    MARIADB_PORT="3306" \
    MARIADB_PASSWORD="jianfeng" \
    MARIADB_USER="root" \
    LOBSTER_DATABASE="lobsters" \
    LOBSTER_HOSTNAME="localhost" \
    LOBSTER_SITE_NAME="Example News" \
    RAILS_ENV="development" \
    SECRET_KEY="" \
    GEM_HOME="/lobsters/.gem" \
    GEM_PATH="/lobsters/.gem" \
    BUNDLE_PATH="/lobsters/.bundle" \
    RAILS_MAX_THREADS="5" \
    SMTP_HOST="127.0.0.1" \
    SMTP_PORT="25" \
    SMTP_STARTTLS_AUTO="true" \
    SMTP_USERNAME="lobsters" \
    SMTP_PASSWORD="lobsters" \
    RAILS_LOG_TO_STDOUT="1" \
    PATH="/lobsters/.gem/ruby/2.7.0/bin:$PATH"

EXPOSE 3000