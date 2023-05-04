FROM public.ecr.aws/lambda/ruby:3.2 AS runtime

RUN yum groupinstall -y 'Development Tools'

WORKDIR ${LAMBDA_TASK_ROOT}

ENV GEM_HOME=${LAMBDA_TASK_ROOT}
ENV EXERCISM_ENV="production"

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && \
    bundle config set deployment 'true' && \
    bundle config set without 'development test' && \
    bundle install

COPY lib/ lib/

CMD [ "lib/chatgpt_proxy.ChatGPTProxy.process" ]

