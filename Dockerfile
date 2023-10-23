# Prva faza: Build stage
FROM ruby:3.2.2-alpine

WORKDIR /rails

# Set production environment
ENV RAILS_ENV="production" \
    BUNDLE_DEPLOYMENT="1" \
    BUNDLE_JOBS="4" \
    BUNDLE_WITHOUT="development:test" \
    BUNDLE_PATH="/usr/local/bundle"

# Install system dependencies
RUN apk --no-cache add \
    build-base \
    postgresql-dev \
    nodejs \
    yarn

# Install tzdata for timezone data
RUN apk --no-cache add tzdata

# Copy your Gemfile and Gemfile.lock to install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy package.json and yarn.lock to install Node.js dependencies
COPY package.json yarn.lock ./
RUN yarn install

# Copy the rest of your application code into the container
COPY . .

# Precompile assets for production

# Expose the port your Rails app will run on (typically 3000)
EXPOSE 3000

# Start the Rails server
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
