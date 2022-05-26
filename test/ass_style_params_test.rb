require "test_helper"

class ASSStyleParamsTest < Minitest::Test
  def setup
    file_path = __dir__ + '/fixtures/example.vtt'
    vtt_file = VTTFile.new(file_path, 1920, 1080)
    @ass_file = ASSFile.new(File.basename(file_path).gsub('.vtt', ''), 1920, 1080)
    @ass_file.convert_vtt_to_ass(vtt_file, 'Open Sans Semibold', 52)
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
