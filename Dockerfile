FROM ruby:3.2.2

RUN apt-get update && apt-get install -y nodejs postgresql-client
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" > /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install -y yarn
RUN apt-get update && apt-get install -y redis-server

# Dodajte liniju za instalaciju redis-cli
RUN apt-get update && apt-get install -y redis-tools

RUN mkdir /app
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN bundle install
COPY . .

RUN yarn install --check-files
RUN rake assets:precompile

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]

