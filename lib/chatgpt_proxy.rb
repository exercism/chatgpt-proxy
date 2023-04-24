require "json"
require "mandate"
require "fileutils"
require "openai"
require "rest-client"
require "exercism-config"

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect("chatgpt_proxy" => "ChatGPTProxy")
loader.inflector.inflect("query_chatgpt" => "QueryChatGPT")
loader.setup

module ChatGPTProxy
  def self.process(event:, context:) # rubocop:disable Lint/UnusedMethodArgument
    event_body = JSON.parse(event["body"], symbolize_names: true)
    ProcessRequest.(event_body)

    {
      statusCode: 200,
      statusDescription: "200 OK",
      headers: { 'Content-Type': 'application/json' },
      isBase64Encoded: false,
      body: {}.to_json
    }
  end
end
