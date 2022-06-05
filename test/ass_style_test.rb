# frozen_string_literal: true

require 'test_helper'

class ASSStyleTest < Minitest::Test
  def setup
    fixtures_path = "#{__dir__}/fixtures/"
    vtt_file_path = "#{fixtures_path}Cute_Executive_Officer_Episode_1.Eng.vtt"
    vtt_file = VTTFile.new(vtt_file_path, 1920, 1080)
    @ass_file = ASSFile.new(File.basename(vtt_file_path).gsub('.vtt', ''), 1920, 1080)
    @ass_file.convert_vtt_to_ass(vtt_file, 'Open Sans Semibold', 52)
  end

  def test_ass_style_color_name
    assert ASSStyle.convert_color('white'.dup) == '&H00FFFFFF'
  end

  def test_ass_style_color_hex_short
    assert ASSStyle.convert_color('#fff'.dup) == '&H00FFFFFF'
  end

  def test_ass_style_color_hex_long
    assert ASSStyle.convert_color('#ffffff'.dup) == '&H00FFFFFF'
  end
end
