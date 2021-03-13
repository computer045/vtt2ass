require "test_helper"

class Vtt2assTest < Minitest::Test

  def setup
    file_path = __dir__ + '/fixtures/Cute Executive Officer [1080p].vtt'
    @vtt_file = VTTFile.new(file_path)
    @ass_file = ASSFile.new(File.basename(file_path).gsub('.vtt', ''), 1920, 1080)
    @ass_file.convertVTTtoASS(@vtt_file, 'Open Sans Semibold', 52)
  end

  def test_that_it_has_a_version_number
    refute_nil ::Vtt2ass::VERSION
  end

  def test_that_vtt_file_is_not_nil
    refute_nil @vtt_file
  end

  def test_that_vtt_file_has_lines
    refute_nil @vtt_file.lines
  end

  def test_that_vtt_file_is_instance_of_VTTFile
    assert_instance_of VTTFile, @vtt_file
  end

  def test_that_vtt_file_has_at_least_one_line
    assert @vtt_file.lines.count >= 1
  end

  def test_that_vtt_line_is_instance_of_VTTLine
    assert_instance_of VTTLine, @vtt_file.lines[8]
  end

  def test_vtt_line_time_start_format
    assert_match (/([\d:]*)\.?(\d*)/), @vtt_file.lines[22].time_start
  end

  def test_vtt_line_time_end_format
    assert_match (/([\d:]*)\.?(\d*)/), @vtt_file.lines[22].time_end
  end

  def test_vtt_line_style_not_empty
    refute_empty @vtt_file.lines[12].style
  end

  def test_vtt_line_text_not_empty
    refute_empty @vtt_file.lines[88].text
  end

  def test_ass_file_creation_not_nil
    refute_nil @ass_file
  end

  def test_ass_file_styles_not_empty
    refute_empty @ass_file.ass_styles
  end

  def test_ass_file_lines_not_empty
    refute_empty @ass_file.ass_lines
  end

  def test_ass_line_time_start_format
    assert_match (/\d:\d\d:\d\d.\d\d/), @ass_file.ass_lines[15].time_start
  end

  def test_ass_line_time_end_format
    assert_match (/\d:\d\d:\d\d.\d\d/), @ass_file.ass_lines[15].time_end
  end

  def test_ass_style_params_horizontal_margin_valid
    s_params = ASSStyleParams.new('position:15%', 1920, 1080)
    assert s_params.horizontal_margin == 285
  end

  def test_ass_style_params_vertical_margin_top_valid
    s_params = ASSStyleParams.new('line:15%', 1920, 1080)
    assert s_params.vertical_margin == 150
  end

  def test_ass_style_params_vertical_margin_bottom_valid
    s_params = ASSStyleParams.new('line:55%', 1920, 1080)
    assert s_params.vertical_margin == 450
  end

  def test_ass_style_params_alignment_center_valid
    s_params = ASSStyleParams.new('align:middle', 1920, 1080)
    assert s_params.alignment == 2
  end

  def test_ass_style_params_alignment_left_valid
    s_params = ASSStyleParams.new('align:left', 1920, 1080)
    assert s_params.alignment == 1
  end

  def test_ass_style_params_alignment_right_valid
    s_params = ASSStyleParams.new('align:right', 1920, 1080)
    assert s_params.alignment == 3
  end

end
