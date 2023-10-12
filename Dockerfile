FROM ruby:3.0-bullseye as base

RUN apt-get update -qq && apt-get install -y build-essential apt-utils libpq-dev nodejs

WORKDIR /docker/jwt_authentication

RUN gem install bundler

COPY Gemfile Gemfile.lock ./

RUN bundle install

ADD . /docker/jwt_authentication

# ARG DEFAULT_PORT 3001

# CMD ["rails", "server", "-b", "0.0.0.0"]