# Imports
require 'optparse'

# Relative imports
require_relative 'vtt2ass/version'
require_relative 'vtt2ass/Application'

module Vtt2ass
    ##
    # This function creates a new application instance and starts the process.
    #
    # It also defines the arguments that can be provided from the CLI.
    def main
        options = {}

        OptionParser.new do |opts|
            opts.banner = "Usage: vtt2ass [options]"
            opts.separator ""
            opts.separator "Specific options:"
            opts.on("-i", "--input DIRECTORY", "Specify a custom input directory (default: './input')") do |dir|
                options[:input] = dir
            end
            opts.on("-o", "--output DIRECTORY", "Specify a custom output directory (default: './output')") do |dir|
                options[:output] = dir
            end
            opts.on("-s", "--font-size SIZE", Integer, "Specify a font size for the subtitles (default: 72)") do |size|
                options[:font_size] = size
            end
            opts.on("-v", "--version", "Show version") do
                puts Vtt2ass::VERSION
                exit
            end
        end.parse!

        app = Application.new(options)
        app.start
    end

    module_function :main
end
