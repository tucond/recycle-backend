FROM amd64/ruby:3.1.2
RUN apt-get update -qq \
 && apt-get install -y nodejs postgresql-client npm \
 && rm -rf /var/lib/apt/lists/* \
 && npm install --global yarn
WORKDIR /app4
COPY Gemfile /app4/Gemfile
COPY Gemfile.lock /app4/Gemfile.lock
RUN gem install bundler
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
# EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "8080"]

EXPOSE 8080
#EXPOSE 3000 1234 26162
