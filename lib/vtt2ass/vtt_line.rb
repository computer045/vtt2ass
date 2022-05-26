# frozen_string_literal: true

##
# This class defines a VTT subtile line.
class VTTLine
  attr_accessor :style
  attr_reader :time_start, :time_end, :params, :text

  ##
  # This method creates an instance of an VTTLine.
  #
  # * Requires +paragraph+, a VTT formatted string as input.
  def initialize(paragraph, width, height)
    lines = paragraph.split("\n")
    rx = /^([\d:.]*) --> ([\d:.]*)\s?(.*?)\s*$/
    @style = 'Main'
    @text, @time_start, @time_end, @params = ''
    count = 0

    lines.each do |line|
      m = line.match(rx)
      if !m && count.zero?
        @style = line
      elsif m
        @time_start = m[1]
        @time_end = m[2]
        @params = m[3]
        ass_style = ASSStyleParams.new(@params, width, height)
        @style = 'MainTop' if @style.eql?('Main') && ass_style.alignment == 8
      else
        @text += "#{line}\n"
      end
      count += 1
    end

    @text = @text.lstrip
  end

  ##
  # This method assigns the object values and outputs a VTT dialogue line.
  def to_s
    "#{@style} \n#{@time_start} --> #{@time_end} #{@params}\n#{@text}"
  end
end
