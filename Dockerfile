# Use a specific version of Ruby and Alpine
FROM ruby:3.2.2-alpine3.18

# Install dependencies
RUN apk --update add \
  nodejs \
  netcat-openbsd \
  postgresql-dev

# Install additional build dependencies (if needed)
RUN apk --update add --virtual build-dependencies \
  make \
  g++

# Create and set the working directory
RUN mkdir /myapp
WORKDIR /myapp

# Copy the Gemfile and Gemfile.lock
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock

# Install gems
RUN bundle install

# Remove build dependencies and cleanup
RUN apk del build-dependencies && rm -rf /var/cache/apk/*

# Copy the rest of the application
ADD . /myapp

# Copy the entrypoint script
COPY docker-entrypoint.sh /usr/local/bin

# Set the entrypoint
ENTRYPOINT ["docker-entrypoint.sh"]
