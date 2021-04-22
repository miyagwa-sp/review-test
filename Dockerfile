FROM ruby:2.7.1

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client locales

WORKDIR /app

COPY Gemfile Gemfile.lock ./

ENV RAILS_SERVE_STATIC_FILES=enabled \
  BUNDLE_JOBS=4 \
  RAILS_LOG_TO_STDOUT=enabled

RUN bundle install

COPY . .

EXPOSE 3000
