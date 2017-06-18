require 'flico/grid'
require 'mini_magick'

module Flico
	
	class Collager
		attr_reader :grid

		def initialize(grid=Grid.new)
      		@grid = grid
    	end

		def call(image_urls)
	      	images = image_urls.map { |p| MiniMagick::Image.open p.path }
	      	temp_file = Tempfile.new ['collage_maker', '.png']
	      	canvas = MiniMagick::Tool::Convert.new do |i|
	        	i.size "#{grid.canv_width}x#{grid.canv_height}"
	        	i.xc "white"
	        	i << temp_file.path
	      	end

	      	resized_images = image_urls.map.with_index do |path, idx|
		        image = MiniMagick::Image.open path.path
		        image.crop(grid.crop_rectangle(idx, image.width, image.height).to_mm)
		        image.resize(grid.resize_rectangle(idx, image.width, image.height).to_mm)
	        	print_to_canvas(image, grid.cell_rectangle(idx), temp_file)
	      	end
	      	temp_file
	    end

	    private

	    def print_to_canvas(image, rectangle, temp_file)
	      	canvas = MiniMagick::Image.new temp_file.path
	      	result = canvas.composite(image) do |c|
	        	c.compose 'Over'
	        	c.geometry rectangle.to_mm
	      	end
	      	result.write temp_file.path
	      	temp_file.rewind
	    end
	    
	end

end
