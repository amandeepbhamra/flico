# frozen_string_literal: true

require 'ostruct'
require 'optparse'
require 'flico/app'

module Flico
  class CommandLineInterface
    def self.parse_args(args)
      options = {}
      OptionParser.new do |opts|
        opts.banner = 'Usage: flico [options] [10 keywords with space as delimiter]'
        opts.on('-f', '--file_name [FileName]', 'Collage FileName') do |f|
          options[:file_name] = f
        end
      end.parse!(args)
      [args, options]
    end

    def self.start(args)
      keywords, options	= parse_args(args)
      App.new(keywords, options).create
    end
  end
end
