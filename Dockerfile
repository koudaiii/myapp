FROM ruby:2.4.1-alpine3.6

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

EXPOSE 5000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
