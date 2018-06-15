FROM jruby:latest
RUN mkdir /unomaly
COPY . /unomaly
WORKDIR /unomaly
RUN bundle install
RUN bundle exec rake vendor
RUN bundle exec rspec spec
RUN gem build logstash-output-unomaly.gemspec

