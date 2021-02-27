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

  def test_vtt_line_start_time_format
    assert_match (/([\d:]*)\.?(\d*)/), @vtt_file.lines[22].time_start
  end

  def test_vtt_line_end_time_format
    assert_match (/([\d:]*)\.?(\d*)/), @vtt_file.lines[46].time_end
  end

  def test_vtt_line_style_not_empty
    refute_empty @vtt_file.lines[12].style
  end

  def test_vtt_line_text_not_empty
    refute_empty @vtt_file.lines[88].text
  end

end
