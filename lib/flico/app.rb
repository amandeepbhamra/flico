# frozen_string_literal: true

module Flico
  class ApplicationError < StandardError; end
  class KeywordMissing < StandardError; end
  class NoImage < StandardError; end
  class FetchingError < StandardError; end

  class App
    attr_reader :resources

    def initialize(resources)
      @resources = resources
    end

    def create_collage
      image_urls = []
      loop do
        image_urls.push get_images
        break unless image_urls.count < 10
      end
      collage(image_urls)
    end

    def collage(images)
      resources.save_collage.call(resources.collager.call(images))
    end

    def get_images
      keyword           = resources.dictionary.call
      image_url         = resources.flickr_api.call(keyword)
      resources.fetch_image.call(image_url)
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
