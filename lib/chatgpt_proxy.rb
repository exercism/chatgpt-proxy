require "json"
require "mandate"
require "fileutils"
require "openai"
require "exercism-config"

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect("chatgpt_proxy" => "ChatGPTProxy")
loader.inflector.inflect("query_chatgpt" => "QueryChatGPT")
loader.setup

module ChatGPTProxy
  def self.process(event:, context:)
    event_body = JSON.parse(event["body"], symbolize_names: true)
    ProcessRequest.(event_body)
  end
end
