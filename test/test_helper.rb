ENV["APP_ENV"] = "test"

# This must happen above the env require below
if ENV["CAPTURE_CODE_COVERAGE"]
  require 'simplecov'
  SimpleCov.start 'rails'
end

gem "minitest"
require "minitest/autorun"
require "minitest/pride"
require "minitest/mock"
require "mocha/minitest"
# require "timecop"

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require "chatgpt_proxy"
