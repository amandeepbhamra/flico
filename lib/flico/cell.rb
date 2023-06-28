# frozen_string_literal: true

module Flico
  class Cell
    attr_reader :x, :y, :width, :height

    def initialize(x = 0, y = 0, width, height)
      @x = x
      @y = y
      @width = width
      @height = height
    end

    def aspect_ratio
      width.to_f / height
    end

    def to_mm
      "#{width}x#{height}+#{x}+#{y}"
    end

    def ==(other)
      other.class == self.class && other.state == state
    end

    protected

    def state
      [@x, @y, @width, @height]
    end
  end
end
