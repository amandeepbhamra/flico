# frozen_string_literal: true

require 'flickraw'

module Flico
  module Flickr
    class BaseApi
      attr_reader :key, :secret, :api

      def initialize
        @key = ENV['FLICKR_KEY']
        @secret = ENV['FLICKR_SECRET']
        @api = flickraw_api
      end

      def get_photo(keyword)
        valid_keyword?(keyword)

        puts "Searching images for keyword: #{keyword}"

        results = search_api(keyword)

        results.count.zero? ? (warn "No Image for keyword: #{keyword}") : photo_url(results.first.id)
      end

      private

      def flickraw_api
        valid_secrets?

        FlickRaw.api_key = key
        FlickRaw.shared_secret = secret
        FlickRaw::Flickr.new
      end

      def valid_secrets?
        if key.nil? || secret.nil?
          warn 'Exiting due to missing required environment variables: FLICKR_KEY or FLICKR_SECRET'
          exit 1
        end

        true
      end

      def search_api(keyword)
        api.photos.search({ text: keyword, per_page: 10, sort: 'interestingness-desc' })
      end

      def info_api(image)
        api.photos.getInfo(photo_id: image)
      end

      def size_api(id)
        api.photos.getSizes(photo_id: id)
      end

      def photo_url(id)
        size_api(id).find { |v| v['label'] == 'Square' }['source']
      end

      def valid_keyword?(keyword)
        warn "Missing Keywords (can't be nil)" if keyword.nil?
      end
    end
  end
end
