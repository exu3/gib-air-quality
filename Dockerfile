FROM ruby:3.0.3

WORKDIR /usr/src/app

RUN apt-get update -qq && apt-get install -y nodejs npm
RUN npm install -g yarn

COPY Gemfile Gemfile.lock ./

RUN bundle install
RUN yarn install --check-files

COPY . .

CMD ["bin/rails", "server"]