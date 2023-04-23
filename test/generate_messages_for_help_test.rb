require 'test_helper'

module ChatGPTProxy
  class GenerateMessagesForHelpTest < Minitest::Test
    def test_calls_help_correctly
      chatgpt_text = "Response from ChatGPT"
      track_title = "Some track title"
      tests = "Some tests text"
      instructions = "Some instructions text"
      submission = "Some submission"

      system_message = format(GenerateMessagesForHelp::SYSTEM_MESSAGE, track_title:)
      user_message = format(GenerateMessagesForHelp::USER_MESSAGE, instructions:, test_suite: tests, submission:)

      messages = [
        { role: "system", content: system_message },
        { role: "user", content: user_message }
      ]

      actual = ChatGPTProxy::GenerateMessagesForHelp.(track_title, instructions, tests, submission)
      assert_equal messages, actual
    end
  end
end
