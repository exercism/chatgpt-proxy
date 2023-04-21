require "json"
require "mandate"
require "fileutils"

require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.inflector.inflect("chatgpt_proxy" => "ChatGPTProxy")
loader.setup

module ChatGPTProxy
  def self.process(event:, context:)
    ProcessRequest.(event, context)
  end
end

