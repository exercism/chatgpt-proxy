FROM public.ecr.aws/lambda/ruby:3.2 AS runtime

WORKDIR ${LAMBDA_TASK_ROOT}

ENV GEM_HOME=${LAMBDA_TASK_ROOT}
ENV EXERCISM_ENV="production"

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY lib/ lib/

CMD [ "lib/chatgpt_proxy.ChatGPTProxy.process" ]

