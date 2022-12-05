FROM ruby:3.2-rc-alpine3.17

WORKDIR /advent_of_code_2022

VOLUME vol1

COPY . ./

RUN gem install bundler \ 
	bundle check || bundle install

