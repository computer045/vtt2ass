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
            opts.on("-i", "--input PATH", "Specify a custom input file or directory (default: './')") do |file_path|
                options[:input] = file_path
            end
            opts.on("-o", "--output PATH", "Specify a custom output directory (default: './')") do |file_path|
                options[:output] = file_path
            end
            opts.on("-f", "--font-family FONT", String, "Specify a font family for the subtitles (default: 'Open Sans Semibold')") do |font_family|
                options[:font_family] = font_family
            end
            opts.on("-s", "--font-size SIZE", Integer, "Specify a font size for the subtitles (default: 52)") do |font_size|
                options[:font_size] = font_size
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
