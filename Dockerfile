# FROM ruby:2.4-alpine
FROM ruby:2.4
MAINTAINER josch_a@posteo.net

RUN apt update && apt install -y libpq-dev tzdata yarn nodejs imagemagick ghostscript git firefox-esr

RUN mkdir /bastabiet
WORKDIR /bastabiet

# Bundle first so code changes do not require bundling
COPY ./Gemfile /bastabiet

RUN gem install bundler -v 1.9.0
RUN bundle install

COPY . /bastabiet

RUN bundle exec rake assets:precompile
