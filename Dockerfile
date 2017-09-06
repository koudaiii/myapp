FROM ruby:2.4.1-alpine

#  Ruby
#-----------------------------------------------
ENV BUNDLER_VERSION 1.14.4

RUN gem install bundler --version "$BUNDLER_VERSION" \
# Ignore warning: "Don't run Bundler as root."
# @see https://github.com/docker-library/rails/issues/10
  && bundle config --global silence_root_warning 1 \
# Ignore insecure `git` protocol for gem
  && bundle config --global git.allow_insecure true

# Disable spring for good
ENV DISABLE_SPRING 1


#  Timezone
#-----------------------------------------------
ENV TIMEZONE Asia/Tokyo

RUN apk --no-cache --update add tzdata \
    && ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime


#  Library
#-----------------------------------------------
RUN apk add --no-cache --update \
      bash \
      ca-certificates \
      nodejs \
      postgresql-dev


#  App
#-----------------------------------------------
WORKDIR /app

COPY Gemfile /app/
COPY Gemfile.lock /app/

RUN apk add --no-cache --virtual build-deps --update \
      g++ \
      linux-headers \
      make \
    && bundle install \
      --deployment \
      --without test development \
      --jobs 8 \
    && apk del build-deps

COPY . /app

RUN mkdir -p \
    log \
    tmp/cache \
    tmp/pids \
    tmp/sockets

EXPOSE 3000

CMD ["bundle","exec","rails","s","Puma","-p","3000"]
