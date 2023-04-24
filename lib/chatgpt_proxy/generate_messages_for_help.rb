module ChatGPTProxy
  class GenerateMessagesForHelp
    include Mandate

    initialize_with :track_title, :instructions, :tests, :submission

    def call
      [
        { role: "system", content: system_message },
        { role: "user", content: user_message }
      ]
    end

    def system_message
      format(SYSTEM_MESSAGE, track_title:)
    end

    def user_message
      format(USER_MESSAGE, instructions:, test_suite: tests, submission:)
    end

    # rubocop:disable Naming/HeredocDelimiterNaming
    SYSTEM_MESSAGE = <<~EOM.chomp
      You are a mentor helping someone get unstuck on a programming problem. The programming language is %<track_title>s.

      The user will give you three things:
      - Their solution so far.
      - A test suite they are trying to code against. Sme tests are marked as skipped. You should ignore this and pretend they are not skipped.
      - The instructions they are following. The end of the instructions may be cut off.

      You will list 1 - 3 bullet points with hints as to why the solution doesn't work. Do not write any text before the bullet points. Do not write any text after the bullet points.
      If there is one major issue with the code, only suggest that issue.
      The response should be markdown.
      You can tell them what they're doing wrong and give them a HINT as to how to improve it, but you should NOT give them the correct code.
      You should have a very high confidence that the hints you're making are correct.
    EOM

    USER_MESSAGE = <<~EOM.chomp
      The user's solution is:
      %<submission>s

      ---

      The test suite is:
      %<test_suite>s

      ---

      The instructions are:

      %<instructions>s
    EOM
    # rubocop:enable Naming/HeredocDelimiterNaming
  end
end
