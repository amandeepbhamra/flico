# frozen_string_literal: true

module Flico
  class Dictionary
    def initialize(dictionary_path)
      @dictionary_path = dictionary_path
      @words = []
    end

    def call
      @words.shift || dictionary_word
    end

    def append(keywords)
      @words += keywords
    end

    private

    def dictionary_word
      File.readlines("/usr/share/dict/words").select { |word| word.size > 3 && word.size < 10 }.sample.strip
    end
  end
end
