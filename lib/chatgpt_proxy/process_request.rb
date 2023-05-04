module ChatGPTProxy
  class ProcessRequest
    include Mandate

    initialize_with :data

    def call
      chatgpt_response = QueryChatGPT.(type, chatgpt_version, data)

      RestClient.post(spi_url, {
        submission_uuid:,
        type:,
        chatgpt_version:,
        chatgpt_response:
      })
    end

    private
    def spi_url = "#{Exercism.config.spi_url}/spi/chatgpt_responses"
    def submission_uuid = data[:submission_uuid]
    def type = data[:type].to_sym
    def chatgpt_version = data[:chatgpt_version]
  end
end
