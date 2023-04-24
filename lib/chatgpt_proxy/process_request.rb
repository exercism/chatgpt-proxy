module ChatGPTProxy
  class ProcessRequest
    include Mandate

    initialize_with :data

    def call
      chatgpt_response = QueryChatGPT.(type, data)

      RestClient.post(spi_url, {
        submission_uuid:,
        type:,
        chatgpt_response:
      })
    end

    private
    def spi_url = "#{Exercism.config.spi_url}/spi/chatgpt_responses"
    def submission_uuid = data[:submission_uuid]
    def type = data[:type].to_sym
  end
end
