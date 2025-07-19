FROM ruby:3.3.8

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
    postgresql-client \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy Gemfile and install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the application
COPY . .

# Precompile assets
RUN RAILS_ENV=production bundle exec rails assets:precompile

# Expose port
EXPOSE 3000

# Start the application
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "3000", "-e", "production"]