# frozen_string_literal: true

require 'thor'

require_relative 'vtt2ass/version'
require_relative 'vtt2ass/application'

class MainCommand < Thor
  def self.exit_on_failure?
    true
  end

  desc 'convert INPUT', 'Run the VTT to ASS conversion for the specified file(s)'
  method_option :output,      aliases: '-o', desc: 'Output directory of the converted file',
                              lazy_default: './', type: :string
  method_option :title,       aliases: '-t',
                              desc: 'Specify a title for you file. If the input is a directory, all files will share the same title.', type: :string
  method_option :font_size,   aliases: '-s', desc: 'Specify a font size for the subtitles', default: 52,
                              type: :numeric
  method_option :font_family, aliases: '-f', desc: 'Specify a font family for the subtitles',
                              default: 'Open Sans Semibold', type: :string
  method_option :css,         aliases: '-c', desc: 'Specify a CSS file path for Hidive subs', type: :string
  method_option :line_offset, aliases: '-l',
                              desc: 'Specify a line offset for the main dialog (e.g. 50 lowers the text line by 50px of the total height)', default: 0, type: :numeric
  method_option :quiet,       aliases: '-q', desc: 'Don\'t output to the console', type: :boolean
  def convert(input)
    app = Application.new(input, options)
    app.start
  end

  desc 'version', 'Show version'
  def version
    puts Vtt2ass::VERSION
  end
end
