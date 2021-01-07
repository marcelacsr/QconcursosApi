FROM ruby:2.7.2-alpine
RUN apk update && apk add bash mariadb-dev tzdata ruby-dev build-base curl git less libxml2-dev libxslt-dev
WORKDIR /QconcursosApi
COPY Gemfile /QconcursosApi/Gemfile
#COPY Gemfile.lock /QconcursosApi/Gemfile.lock
#RUN bundle install
COPY . /QconcursosApi

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["bin/rails", "server", "-b", "0.0.0.0"]