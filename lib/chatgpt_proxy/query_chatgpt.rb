module ChatGPTProxy
  class QueryChatGPT
    include Mandate

    initialize_with :type, :version, :data

    def call
      response = chatgpt_client.chat(
        parameters: {
          model:,
          messages:,
          temperature: 0.3
        }
      )

      response.dig("choices", 0, "message", "content")
    end

    memoize
    def messages
      case type
      when :help
        GenerateMessagesForHelp.(
          track_title, instructions, tests, submission
        )
      when :feedback
        raise "Not done feedback yet"
      else
        raise "Unknown type. Should be one of [help, feedback]"
      end
    end

    def track_title = data[:track_title]
    def instructions = data[:instructions]
    def tests = data[:tests]
    def submission = data[:submission]

    memoize
    def chatgpt_client
      OpenAI::Client.new(
        access_token: Exercism.secrets.chatgpt_access_token,
        request_timeout: 30
      )
    end

    def model
      version == "4.0" ? "gpt-4" : "gpt-3.5-turbo"
    end
  end
end
