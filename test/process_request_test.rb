require 'test_helper'

class ChatGPTProxy::ProcessRequestTest < Minitest::Test
  def test_proxies_to_query_and_constructs_return
    body = {}
    submission_uuid = SecureRandom.uuid
    type = 'help'
    text = "chatgpt response"
    data = {
      submission_uuid: ,
      type: ,
      foo: 'bar'
    }

    ChatGPTProxy::QueryChatGPT.expects(:call).
      with(type.to_sym, data).
      returns(text)

    expected = {
      statusCode: 200,
      statusDescription: "200 OK",
      headers: { 'Content-Type': 'application/json' },
      isBase64Encoded: false,
      body: {
          submission_uuid: ,
          type: type.to_sym,
          chatgpt_response: text
      }
    }

    assert_equal expected, ChatGPTProxy::ProcessRequest.(data)
  end
end
