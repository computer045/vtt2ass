require "test_helper"

class ASSFileTest < Minitest::Test
  def setup
    file_path = __dir__ + '/fixtures/example.vtt'
    vtt_file = VTTFile.new(file_path, 1920, 1080)
    @ass_file = ASSFile.new(File.basename(file_path).gsub('.vtt', ''), 1920, 1080)
    @ass_file.convert_vtt_to_ass(vtt_file, 'Open Sans Semibold', 52)
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
end
