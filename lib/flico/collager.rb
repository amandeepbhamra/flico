# frozen_string_literal: true

require 'mini_magick'

module Flico
  class Collager
    attr_reader :images_url, :file_name

    def initialize(images_url, file_name)
      @images_url = images_url
      @file_name = file_name
    end

    def save
      montage = MiniMagick::Tool::Montage.new
      montage.density '600'
      montage.tile '5X2'
      montage.geometry '+10+20'
      montage.border '5'
      images_url.each { |image_url| montage << image_url }
      montage << file_name
      montage.call
    end
  end
end
