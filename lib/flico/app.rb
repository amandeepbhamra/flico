# frozen_string_literal: true

require 'flico/dictionary'
require 'flico/collager'
require 'flico/image_file'

module Flico
  class ApplicationError < StandardError; end

  class App
    KEYWORDS_COUNT = 10

    attr_reader :keywords, :options

    def initialize(keywords, options)
      @keywords = add_missing_keywords(keywords)
      @options = options
    end

    def create
      options[:file_name] = prepare_file_name(options)

      Collager.new(prepare_images, options[:file_name]).save

      puts "Flicollage saved at #{options[:file_name]}"
    end

    def prepare_images
      keywords.map { |keyword| ImageFile.new(keyword).fetch_from_flickr }
    end

    private

    def add_missing_keywords(words)
      words_count = words.size
      return words if words_count == KEYWORDS_COUNT

      words += Dictionary.new.words(KEYWORDS_COUNT - words_count)
      puts "KEYWORDS: #{words}"
      words
    end

    def prepare_file_name(options)
      return options[:file_name] unless options[:file_name].nil?

      puts 'Enter file name for collage (press ENTER to use default)'
      file_name = $stdin.gets.strip
      file_name.empty? ? "flicollage-#{Time.now.strftime('%Y%m%d%H%M%S')}.png" : file_name
    end
  end
end
