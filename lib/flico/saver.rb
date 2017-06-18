require 'open-uri'
require 'tempfile'
require 'fileutils'
require 'date'


module Flico

	class FetchingError < StandardError; end

	class FetchImage

		def call(url)
			tempfile = Tempfile.new 'temp_image'
			IO.copy_stream(open(url, read_timeout: 5), tempfile)
			tempfile.rewind
			tempfile
			rescue OpenURI::HTTPError => e
			raise FetchingError, "Couldn't download from: #{url} due to #{e.message}"
		end

	end

	class SaveCollage

		attr_accessor :output_file_name

		def call(file_path)
	      	file_name = output_file_name || validate_file_name
	      	FileUtils.mv file_path, file_name
	      	puts "Flicollage saved at #{file_name}"
	    end

	    private

	    def validate_file_name
	      	puts "Enter file name for collage (press ENTER to use '#{default}')"
	      	file_name = STDIN.gets.strip
			file_name.empty? ? "flicollage-#{Time.now.strftime('%Y%m%d%H%M%S')}.png" : file_name
	    end

	end

end
