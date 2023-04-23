class ChatGPTProxy::GenerateMessagesForHelp
  include Mandate

  initialize_with :track_title, :instructions, :tests, :submission

  def call
    [
      { role: "system", content: system_message },
      { role: "user", content: user_message }
    ]
  end

  def system_message
    SYSTEM_MESSAGE % { track_title: track_title }
  end

  def user_message
    USER_MESSAGE % {
      instructions: instructions,
      test_suite: tests,
      submission: submission
    }
  end

  # rubocop:disable Naming/HeredocDelimiterNaming
  SYSTEM_MESSAGE = <<~EOM.chomp
    You are a mentor helping someone get unstuck on a programming problem. The programming language is %<track_title>s.

    The user will give you three things:
    - The instructions they are following, in Markdown.
    - A test suite they are trying to code against. In the test suite, some tests are marked as skipped. You should ignore this and pretend they are not skipped.
    - Their solution so far.

    You will list 1 - 3 bullet points with hints as to why the solution doesn't work. You can tell them what they're doing wrong and give them a HINT as to how to improve it, but you should NOT give them the correct code.

    The response should be markdown.

    You should have a very high confidence that the hints you're making are correct.
    If there is one major issue with the code, only suggest that issue.

    You should ONLY give 1-3 bullet points. Do not write any text before the bullet points. Do not write any text after the bullet points.
  EOM

  USER_MESSAGE = <<~EOM.chomp
    The instructions are:

    %<instructions>s

    ---

    The test suite is:
    %<test_suite>s

    ---

    The user's solution is:
    %<submission>s
  EOM
  # rubocop:enable Naming/HeredocDelimiterNaming
end

