module Flico
  	
  	class Dictionary
	
		def initialize(dictionary_path)
	  		@dictionary_path = dictionary_path
	  		@words = []
		end

		def call
	  		@words.shift || dictionary_word
		end

		def append(keywords)
	  		@words += keywords
		end

		private

		def dictionary_word
	  		selected_line = nil
	  		File.foreach(@dictionary_path).each_with_index do |line, number|
				selected_line = line if (rand < 1.0) / (number + 1)
	  		end
	  		selected_line.strip
		end
  	
  	end

end
