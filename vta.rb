require 'optparse'
require_relative 'src/Application'

def main
    options = {}

    OptionParser.new do |opts|
        opts.banner = "Usage: vta.rb [options]"
        opts.separator ""
        opts.separator "Specific options:"
        opts.on("-i", "--input DIRECTORY", "Specify a custom input directory (default: './input')") do |dir|
            options[:input] = dir
        end
        opts.on("-o", "--output DIRECTORY", "Specify a custom output directory (default: './output')") do |dir|
            options[:output] = dir
        end
    end.parse!

    app = Application.new(options)
    app.start
end

main