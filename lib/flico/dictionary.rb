# frozen_string_literal: true

module Flico
  class Dictionary
    PATH = '/usr/share/dict/words'
    ALPHABETS_LOWER_LIMIT = 3
    ALPHABETS_UPPER_LIMIT = 10

    def initialize
      @dictionary_path = validate(PATH)
      @words = []
    end

    def words(count)
      @words += pick_words(count)
    end

    private

    def pick_words(count)
      File.readlines(PATH).select do |word|
        word.size > ALPHABETS_LOWER_LIMIT && word.size < ALPHABETS_UPPER_LIMIT
      end.sample(count).map(&:strip)
    end

    def validate(path)
      unless File.exist?(path)
        warn "Exiting due to missing dictionary at path: #{path}"
        exit 1
      end

      path
    end
  end
end
