require 'flickraw'
require 'ostruct'
require 'optparse'
require 'flico/app'
require 'flico/flickr_command'
require 'flico/dictionary'
require 'flico/saver'
require 'flico/collager'

module Flico

	class CommandLineInterface

		def self.parse_args(args)
	      	options = {}
			OptionParser.new do |opts|
			  opts.banner = "Usage: flico [options] [10 keywords with space as delimiter]"
			  opts.on("-f", "--file_name [FileName]", "Collage FileName") do |f|
			    options[:file_name] = f
			  end
			end.parse!(args)	      	
	      	[args, options]
	    end
	    
	    def self.start(args)
	      	keywords, options 	= parse_args(args)	      
	      	puts "Given Keywords: #{keywords.join(' ')} with Options: #{options}"
	      	resources 			= validate_resources(keywords, options)
	      	App.new(resources).create_collage
	    end

	    def self.validate_resources(keywords, options={})
	      	dictionary = validate_dictionary
	      	dictionary.append(keywords)
	      	col = SaveCollage.new
	      	col.output_file_name = options[:file_name]

			Resource.new(flickr_api: validate_flickr_api, dictionary: dictionary, fetch_image: FetchImage.new, collager: Collager.new, save_collage: col)
	    end

	    def self.validate_flickr_api
	    	key, secret = ENV['FLICKR_KEY'], ENV['FLICKR_SECRET']
	    	unless key == nil && secret == nil
	    		FlickRaw.api_key 		= key
	        	FlickRaw.shared_secret 	= secret
	        	FlickrCommand.setup(FlickRaw::Flickr.new)
	    	else
	    		STDERR.puts "Performing AutoExit due to missing required environment variables: FLICKR_KEY and FLICKR_SECRET"
	        	exit 1
	    	end
	    end

	    def self.validate_dictionary
	    	dictionary_path = '/usr/share/dict/words'
	      	if File.exist?(dictionary_path)
	      		dictionary = Dictionary.new(dictionary_path)	        	
	      	else
	      		STDERR.puts "Performing AutoExit due to missing required dictionary at path: #{dictionary_path}"
	        	exit 1
	      	end
	    end    

	end

	class Resource
    
    	attr_reader :flickr_api, :dictionary, :fetch_image, :collager, :save_collage

    	def initialize(params={})
    		@flickr_api 	= params.fetch(:flickr_api) 
    		@dictionary 	= params.fetch(:dictionary) 
    		@fetch_image 	= params.fetch(:fetch_image) 
    		@collager 		= params.fetch(:collager) 
    		@save_collage 	= params.fetch(:save_collage)      		
    	end

  	end

end
