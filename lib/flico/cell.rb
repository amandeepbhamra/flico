module Flico

	class Cell
		attr_reader :x, :y, :width, :height

		def initialize(x=0, y=0, width, height)
			@x, @y 			= x, y
			@width, @height = width, height
		end

		def aspect_ratio
			width.to_f / height.to_f
		end

		def to_mm
			"#{width}x#{height}+#{x}+#{y}"
		end

		def ==(o)
			o.class == self.class && o.state == state
		end

		protected

		def state
			[@x, @y, @width, @height]
		end
	end

end
