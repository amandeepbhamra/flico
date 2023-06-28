# frozen_string_literal: true

module Flico
  class FlickrCommand
    def initialize(search_command:, sizes_command:)
      @search_command = search_command
      @sizes_command = sizes_command
    end

    def self.setup(flickraw)
      new(search_command: SearchCommand.new(flickraw), sizes_command: SizesCommand.new(flickraw))
    end

    def call(keyword)
      if keyword.nil?
        warn "Missing Keywords (can't be nil)"
      else
        puts "Searching images for keyword: #{keyword}"
        results = @search_command.call(keyword)
        if results.count.zero?
          warn "No Image for keyword: #{keyword}"
        else
          get_image_url(results.first['id'])
        end
      end
    end

    private

    def get_image_url(photo_id)
      sizes	= @sizes_command.call(photo_id)
      sizes[sizes.count / 2]['source']
    end
  end

  class FlickrBase
    attr_reader :api

    def initialize(flickraw)
      @api = flickraw
    end
  end

  class SearchCommand < FlickrBase
    def call(keyword)
      api.photos.search({ text: keyword, per_page: 10, sort: 'interestingness-desc' })
    end
  end

  class SizesCommand < FlickrBase
    def call(photo_id)
      api.photos.getSizes(photo_id:)
    end
  end
end
