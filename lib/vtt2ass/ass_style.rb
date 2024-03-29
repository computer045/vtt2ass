# frozen_string_literal: true

require_relative 'ass_style_params'
require_relative 'validator'
require 'redgreenblue'

##
# This class defines an ASS style that can be applied on a subtitle line.
class ASSStyle
  attr_reader :style_name

  ##
  # This method creates and instance of an ASSStyle.
  #
  # * Requires +style_name+, a string name for the style as input.
  # * Requires +params+, a string of VTT styling as input.
  # * Requires a video +width+ as input.
  # * Requires a video +height+ as input.
  def initialize(style_name, params, font_family, font_size, font_color, is_bold, is_italic, offset, width, height)
    @width = width
    @height = height
    @font_family = font_family
    @font_size = font_size
    @font_color = font_color
    @style_name = style_name
    @s_params = ASSStyleParams.new(params, width, height)
    @s_params.vertical_margin = 50 if style_name.eql? 'MainTop'
    @s_params.vertical_margin -= offset[:line] if style_name.include?('Subtitle') || style_name.eql?('Main')
    @s_params.vertical_margin += offset[:caption] if style_name.include?('Caption') || style_name.eql?('MainTop')
    @is_italic = is_italic
    @is_bold = is_bold
  end

  ##
  # This method assigns the object values to an ASS style line and outputs it.
  def to_s
    # Format: Name, Fontname, Fontsize, PrimaryColour, SecondaryColour, OutlineColour, BackColour,
    # Bold, Italic, Underline, StrikeOut, ScaleX, ScaleY, Spacing, Angle, BorderStyle, Outline, Shadow, Alignment,
    # MarginL, MarginR, MarginV, Encoding
    "Style: #{@style_name},#{@font_family},#{@font_size},#{@font_color},&H000000FF,&H00020713,&H00000000,"\
      "#{@is_bold ? '-1' : '0'},#{@is_italic ? '-1' : '0'},0,0,100,100,0,0,1,2.0,2.0,#{@s_params.alignment},"\
      "#{@s_params.horizontal_margin},0,#{@s_params.vertical_margin},1"
  end

  ##
  # This method returns a ASS formated color value based on hex or color name value
  def self.convert_color(color_value)
    color_value.gsub!('#', '')
    color = Validator.hex?(color_value) ? RGB.hex(color_value) : RGB.css(color_value)
    format('&H00%<blue>02x%<green>02x%<red>02x', blue: color.b, green: color.g, red: color.r).upcase
  end
end
