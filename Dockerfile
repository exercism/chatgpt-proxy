FROM public.ecr.aws/lambda/ruby:3.2 AS runtime

WORKDIR ${LAMBDA_TASK_ROOT}

ENV GEM_HOME=${LAMBDA_TASK_ROOT}
COPY Gemfile Gemfile.lock ./

RUN bundle config set deployment 'true' && \
    bundle config set without 'development test' && \
    bundle install

COPY . .

CMD [ "lib.chatgpt_proxy.ChatGPTProxy.process" ]

