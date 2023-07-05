# frozen_string_literal: true

require 'flico/flickr/base_api'

module Flico
  class NoImage < StandardError; end
  class FetchingError < StandardError; end

  class ImageFile
    attr_accessor :keyword

    def initialize(keyword)
      @keyword = keyword
    end

    def fetch_from_flickr
      Flickr::BaseApi.new.get_photo(keyword)
    rescue NoImage => e
      puts "Image not found for keyword '#{keyword}'. Message: #{e.message}. Retrying"
      unless (tries -= 1).positive?
        raise ApplicationError, "Failed getting image after retrying #{MAX_KEYWORD_RETRIES} times"
      end

      retry
    rescue FetchingError => e
      raise ApplicationError, e.message
    end
  end
end
