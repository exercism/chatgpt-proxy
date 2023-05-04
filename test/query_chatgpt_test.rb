require 'test_helper'

module ChatGPTProxy
  class QueryChatGPTTest < Minitest::Test
    def test_calls_help_correctly
      chatgpt_text = "Response from ChatGPT"
      track_title = "Some track title"
      tests = "Some tests text"
      instructions = "Some instructions text"
      submission = "Some submission"

      messages = GenerateMessagesForHelp.(track_title, instructions, tests, submission)

      OpenAI::Client.any_instance.expects(:chat).with(
        parameters: {
          model: "gpt-4",
          messages:,
          temperature: 0.3
        }
      ).returns(
        {
          "choices" => [{ "message" => { "content" => chatgpt_text } }]
        }
      )

      actual = ChatGPTProxy::QueryChatGPT.(:help, '4.0', {
        track_title:, instructions:, tests:, submission:
      })
      assert_equal chatgpt_text, actual
    end
  end
end
