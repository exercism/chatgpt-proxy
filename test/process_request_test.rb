require 'test_helper'

module ChatGPTProxy
  class ProcessRequestTest < Minitest::Test
    def test_proxies_to_query_and_constructs_return
      submission_uuid = SecureRandom.uuid
      type = 'help'
      text = "chatgpt response"
      data = {
        submission_uuid:,
        type:,
        chatgpt_version: '4.0',
        foo: 'bar'
      }

      ChatGPTProxy::QueryChatGPT.expects(:call).
        with(type.to_sym, '4.0', data).
        returns(text)

      RestClient.expects(:post).
        with(
          "#{Exercism.config.spi_url}/spi/chatgpt_responses",
          {
            submission_uuid:,
            type: type.to_sym,
            chatgpt_version: '4.0',
            chatgpt_response: text
          }
        )

      ChatGPTProxy::ProcessRequest.(data)
    end
  end
end
