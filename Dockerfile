FROM ruby:3.0.1

RUN apt-get update -qq && apt-get install -y nodejs libpq-dev postgresql-client

WORKDIR /var/www/app/current

COPY Gemfile /var/www/app/current/Gemfile
COPY Gemfile.lock /var/www/app/current/Gemfile.lock
CMD bin/start-puma