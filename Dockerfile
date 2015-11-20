FROM ruby:2.2.3

# HACK: httpredir breaks often from Singapore, so....
RUN echo deb http://mirror.0x.sg/debian jessie main > /etc/apt/sources.list && echo deb http://mirror.0x.sg/debian jessie-updates main >> /etc/apt/sources.list && echo deb http://security.debian.org jessie/updates main >> /etc/apt/sources.list

RUN apt-get update -qq && apt-get install -y build-essential \
    libpq-dev postgresql-client \
    libxml2-dev libxslt1-dev \
    libqt4-webkit libqt4-dev xvfb \
    nodejs && \
    rm -rf /var/lib/apt/lists/*

# for postgres
# RUN apt-get install -y libpq-dev postgresql-client

# for nokogiri
# RUN apt-get install -y libxml2-dev libxslt1-dev

# for capybara-webkit
# RUN apt-get install -y libqt4-webkit libqt4-dev xvfb

# for a JS runtime
# RUN apt-get install -y nodejs

# Clean up after apt-get install
# RUN rm -rf /var/lib/apt/lists/*

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# ADD Gemfile $APP_HOME/
# ADD Gemfile.lock $APP_HOME/
# shouldn't this pick up the `Gemfile` and `Gemfile.lock`?
ADD . $APP_HOME
RUN gem install bundler brakeman && bundle install
# These break when run inside the Dockerfile; run them from the host
# RUN bundle install
# RUN bundle exec rake db:create:all db:setup

# The main command to run when the container starts. Also 
# tell the Rails dev server to bind to all interfaces by 
# default.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
