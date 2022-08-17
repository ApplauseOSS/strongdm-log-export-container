# latest version is older
FROM fluent/fluentd:edge-debian

ENV FLUENTD_DIR=fluentd
ENV PATH="/root:$PATH"

USER root
RUN apt-get update && apt-get install -y curl ca-certificates gettext build-essential ruby-dev zlib1g-dev
RUN gem install bundler -v '~> 2.3.3'

COPY Gemfile /Gemfile
RUN bundle install

RUN curl -fsSLo sdm.zip $(curl https://app.strongdm.com/releases/upgrade\?os\=linux\&arch\=$(uname -m | sed -e 's:x86_64:amd64:' -e 's:aarch64:arm64:')\&software\=sdm-cli\&version\=productionexample | jq ".url" -r)
RUN unzip -x sdm.zip
RUN rm sdm.zip
RUN mv sdm /root
RUN apt-get purge curl ca-certificates wget
RUN mkdir /root/.sdm

COPY fluentd /fluentd
COPY create-conf.rb /create-conf.rb
COPY conf-utils.rb /conf-utils.rb
COPY start.sh /start.sh

USER root
CMD ["/start.sh"]
