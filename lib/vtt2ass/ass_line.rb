# frozen_string_literal: true

require 'htmlentities'

##
# This class defines an ASS subtile line.
class ASSLine
  attr_reader :style, :time_start, :time_end, :text

  ##
  # This method creates an instance of an ASSLine.
  #
  # * Requires a +style+ name as input.
  # * Requires +time_start+, a VTT formatted timestamp as input.
  # * Requires +time_start+, a VTT formatted timestamp as input.
  # * Requires +text+, a VTT formatted string as input.
  def initialize(style, time_start, time_end, text)
    @style = style
    @time_start = convert_time(time_start)
    @time_end = convert_time(time_end)
    @text = convert_to_ass_text(text)
  end

  ##
  # This method assigns the object values and outputs an ASS dialogue line.
  def to_s
    "Dialogue: 0,#{@time_start},#{@time_end},#{@style},,0,0,0,,#{@text}"
  end

  ##
  # This method replaces characters and tags to ASS compatible characters and tags.
  #
  # * Requires +text+, a string of VTT formated text as input.
  def convert_to_ass_text(text)
    decoder = HTMLEntities.new
    text =
      text
      .gsub(/\r/, '')
      .gsub(/\n/, '\\N')
      .gsub(/\\n/, '\\N')
      .gsub(/\\N +/, '\\N')
      .gsub(/ +\\N/, '\\N')
      .gsub(/(\\N)+/, '\\N')
      .gsub(%r{<b[^>]*>([^<]*)</b>}) { |_s| "{\\b1}#{Regexp.last_match(1)}{\\b0}" }
      .gsub(%r{<i[^>]*>([^<]*)</i>}) { |_s| "{\\i1}#{Regexp.last_match(1)}{\\i0}" }
      .gsub(%r{<u[^>]*>([^<]*)</u>}) { |_s| "{\\u1}#{Regexp.last_match(1)}{\\u0}" }
      .gsub(%r{<c[^>]*>([^<]*)</c>}) { |_s| Regexp.last_match(1) }
      .gsub(/<[^>]>/, '')
      .gsub(/\\N$/, '')
      .gsub(/ +$/, '')
    decoder.decode(text)
  end

  ##
  # This method validates the time format and sends the matching time to be converted
  #
  # * Requires +str+, a VTT formatted time string.
  def convert_time(time)
    matched_time = time.match(/([\d:]*)\.?(\d*)/)
    to_subs_time(matched_time[0])
  end

  ##
  # This method converts time from VTT format to the ASS format.
  #
  # * Requires +str+, a VTT formatted time string.
  def to_subs_time(str)
    n = []
    x = str.split(/[:.]/).map(&:to_i)

    ms_len = 2
    h_len = 1

    x[3] = "0.#{x[3].to_s.rjust(3, '0')}"
    sx = x[0] * 60 * 60 + x[1] * 60 + x[2] + x[3].to_f
    sx = format('%.2f', sx).split('.')

    n.unshift(pad_time_num('.', sx[1], ms_len))
    sx = sx[0].to_f

    n.unshift(pad_time_num(':', (sx % 60).to_i, 2))
    n.unshift(pad_time_num(':', (sx / 60).floor % 60, 2))
    n.unshift(pad_time_num('',  (sx / 3600).floor % 60, h_len))

    n.join('')
  end

  ##
  # This method pads text so that time numbers are a fixed number of digit.
  #
  # * Requires +sep+, a string separator.
  # * Requires +input+, an integer.
  # * Requires +pad+, an integer for the number of digits to be padded.
  def pad_time_num(sep, input, pad)
    sep + input.to_s.rjust(pad, '0')
  end
end
