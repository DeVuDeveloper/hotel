FROM ruby:3.2-buster

COPY --from=gcr.io/berglas/berglas:latest /bin/berglas /bin/berglas

# Install bundler
RUN gem update --system
RUN gem install bundler

# Install production dependencies.
WORKDIR /usr/src/app
COPY Gemfile Gemfile.lock ./
ENV BUNDLE_FROZEN=true
RUN bundle install

# Copy local code to the container image.
COPY . ./

# Environment
ENV RAILS_ENV production
ENV RAILS_MAX_THREADS 60
ENV RAILS_LOG_TO_STDOUT true

# See entrypoint.sh. Our secrets are managed through Berglas.
ENV RAILS_MASTER_KEY_LINK some-bucket/some-folder/some-app/master.key

# Run the web service on container startup.
CMD ["bash", "entrypoint.sh"]