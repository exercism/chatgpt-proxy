#!/usr/bin/env ruby

ENV["EXERCISM_ENV"] ||= "development"

track_title = "Ruby"

instructions = <<~'EOS'
  Implement a program that translates from English to Pig Latin."

  Pig Latin is a made-up children's language that's intended to be confusing.
  It obeys a few simple rules (below), but when it's spoken quickly it's really difficult for non-children (and non-native speakers) to understand.

  - **Rule 1**: If a word begins with a vowel sound, add an "ay" sound to the end of the word.
    Please note that "xr" and "yt" at the beginning of a word make vowel sounds (e.g. "xray" -> "xrayay", "yttria" -> "yttriaay").
  - **Rule 2**: If a word begins with a consonant sound, move it to the end of the word and then add an "ay" sound to the end of the word.
    Consonant sounds can be made up of multiple consonants, a.k.a. a consonant cluster (e.g. "chair" -> "airchay").
  - **Rule 3**: If a word starts with a consonant sound followed by "qu", move it to the end of the word, and then add an "ay" sound to the end of the word (e.g. "square" -> "aresquay").
  - **Rule 4**: If a word contains a "y" after a consonant cluster or as the second letter in a two letter word it makes a vowel sound (e.g. "rhythm" -> "ythmrhay", "my" -> "ymay").

  There are a few more rules for edge cases, and there are regional variants too.

  Read more about [Pig Latin on Wikipedia][pig-latin].

  [pig-latin]: https://en.wikipedia.org/wiki/Pig_latin
EOS

tests = <<~'EOS'
  File: pig_latin_test.rb

  ```
  require 'minitest/autorun'
  require_relative 'pig_latin'

  class PigLatinTest < Minitest::Test
    def test_word_beginning_with_a
      # skip
      assert_equal "appleay", PigLatin.translate("apple")
    end

    def test_word_beginning_with_e
      skip
      assert_equal "earay", PigLatin.translate("ear")
    end

    def test_word_beginning_with_i
      skip
      assert_equal "iglooay", PigLatin.translate("igloo")
    end

    def test_word_beginning_with_o
      skip
      assert_equal "objectay", PigLatin.translate("object")
    end

    def test_word_beginning_with_u
      skip
      assert_equal "underay", PigLatin.translate("under")
    end

    def test_word_beginning_with_a_vowel_and_followed_by_a_qu
      skip
      assert_equal "equalay", PigLatin.translate("equal")
    end

    def test_word_beginning_with_p
      skip
      assert_equal "igpay", PigLatin.translate("pig")
    end

    def test_word_beginning_with_k
      skip
      assert_equal "oalakay", PigLatin.translate("koala")
    end

    def test_word_beginning_with_x
      skip
      assert_equal "enonxay", PigLatin.translate("xenon")
    end

    def test_word_beginning_with_q_without_a_following_u
      skip
      assert_equal "atqay", PigLatin.translate("qat")
    end

    def test_word_beginning_with_ch
      skip
      assert_equal "airchay", PigLatin.translate("chair")
    end

    def test_word_beginning_with_qu
      skip
      assert_equal "eenquay", PigLatin.translate("queen")
    end

    def test_word_beginning_with_qu_and_a_preceding_consonant
      skip
      assert_equal "aresquay", PigLatin.translate("square")
    end

    def test_word_beginning_with_th
      skip
      assert_equal "erapythay", PigLatin.translate("therapy")
    end

    def test_word_beginning_with_thr
      skip
      assert_equal "ushthray", PigLatin.translate("thrush")
    end

    def test_word_beginning_with_sch
      skip
      assert_equal "oolschay", PigLatin.translate("school")
    end

    def test_word_beginning_with_yt
      skip
      assert_equal "yttriaay", PigLatin.translate("yttria")
    end

    def test_word_beginning_with_xr
      skip
      assert_equal "xrayay", PigLatin.translate("xray")
    end

    def test_y_is_treated_like_a_consonant_at_the_beginning_of_a_word
      skip
      assert_equal "ellowyay", PigLatin.translate("yellow")
    end

    def test_y_is_treated_like_a_vowel_at_the_end_of_a_consonant_cluster
      skip
      assert_equal "ythmrhay", PigLatin.translate("rhythm")
    end

    def test_y_as_second_letter_in_two_letter_word
      skip
      assert_equal "ymay", PigLatin.translate("my")
    end

    def test_a_whole_phrase
      skip
      assert_equal "ickquay astfay unray", PigLatin.translate("quick fast run")
    end
  end
  ```
EOS

submission = <<~'EOS'
  File: pig_latin.rb

  ```
  module PigLatin

    def self.translate(phrase)
      phrase.split.map { |word| Translator.translate(word) }.join(" ")
    end

    class Translator
      def self.translate(word)
        new(word).translate
      end

      def initialize(word)
        @word = word
      end

      def translate
        case
        when starts_with_vowel_and_qu?
          word
        when starts_with_vowel?
          word + "a"
        else
          first_sound = word[FIRST_CONSONANT_SOUND]
          word[first_sound.length..-1] + first_sound + "ay"
        end
      end

      private
      attr_reader :word

      def starts_with_vowel_and_qu?
        starts_with_vowel? && !word[1,2] == "qu"
      end

      def starts_with_vowel?
        word.start_with?(*VOWEL_SOUNDS)
      end

      VOWEL_SOUNDS = %w{a e i o u xr yt}
      CONSONANT_SOUNDS = %w{ch squ qu thr th sch yt rh} + ('a'..'z').to_a - VOWEL_SOUNDS
      FIRST_CONSONANT_SOUND = /^#{CONSONANT_SOUNDS.join("|")}/

      private_constant :VOWEL_SOUNDS, :CONSONANT_SOUNDS, :FIRST_CONSONANT_SOUND
    end
  end

  ```
EOS

require("./lib/chatgpt_proxy")

puts ""
puts ""
puts ChatGPTProxy::QueryChatGPT.(:help, {
  track_title:,
  instructions:,
  tests:,
  submission:
})
puts ""
puts ""
