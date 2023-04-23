module ChatGPTProxy
  class ProcessRequest
    include Mandate

    initialize_with :data

    def call
      {
        statusCode: 200,
        statusDescription: "200 OK",
        headers: { 'Content-Type': 'application/json' },
        isBase64Encoded: false,
        body: {
          submission_uuid:,
          type:,
          chatgpt_response:
        }.to_json
      }
    end

    private
    def chatgpt_response = QueryChatGPT.(type, data)
    def submission_uuid = data[:submission_uuid]
    def type = data[:type].to_sym
  end
end
