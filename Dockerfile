FROM public.ecr.aws/lambda/ruby:3.2 AS runtime

WORKDIR ${LAMBDA_TASK_ROOT}

ENV GEM_HOME=${LAMBDA_TASK_ROOT}
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

CMD [ "lambda_function.process" ]

