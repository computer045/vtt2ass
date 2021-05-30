# Imports
require 'tty-option'

# Relative imports
require_relative 'vtt2ass/version'
require_relative 'vtt2ass/Application'

class Command
    include TTY::Option

    usage do
        header 'VTT2ASS'
        program 'vtt2ass'
        command ''
        desc 'Convert VTT subtitles to ASS subtitles'
        example "Convert files in a specific directory",
                "  $ vtt2ass ./path/to/file_input ./path/to/file_output"
    end

    # ------------------------------
    # Arguments
    # ------------------------------

    argument :input do
        optional
        desc "Input directory or file (default: current directory)"
    end

    argument :output do
        optional
        desc "Output directory (default: console output)"
    end

    # ------------------------------
    # Flags
    # ------------------------------

    flag :help do
        short "-h"
        long "--help"
        desc "Print usage"
    end

    flag :version do
        short "-v"
        long "--version"
        desc "Show version"
    end

    flag :quiet do
        short "-q"
        long "--quiet"
        desc "Prevent the command from outputing to the console"
    end

    # ------------------------------
    # Options
    # ------------------------------

    option :title do
        optional
        short "-t STRING"
        long "--title STRING"
        desc "Specify a title for you file. If the input is a directory, all files will share the same title."
    end

    option :font_size do
        optional
        short "-s INTEGER"
        long "--font-size INTEGER"
        desc "Specify a font size for the subtitles (default: 52)"
    end

    option :font_family do
        optional
        short "-f STRING"
        long "--font-family STRING"
        desc "Specify a font family for the subtitles (default: 'Open Sans Semibold')"
    end

    def run
        if params[:help] then
            print help
            exit
        elsif params[:version] then
            puts Vtt2ass::VERSION
            exit
        else
            runner = Application.new(params)
            # pp params.to_h
            runner.start
        end
    end
end

module Vtt2ass
    def main
        app = Command.new
        app.parse
        app.run
    end

    module_function :main
end
