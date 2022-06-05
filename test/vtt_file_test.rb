# frozen_string_literal: true

require 'test_helper'

class VTTFileTest < Minitest::Test
  def setup
    file_path = "#{__dir__}/fixtures/example.vtt"
    @vtt_file = VTTFile.new(file_path, 1920, 1080)
  end

  def test_that_vtt_file_is_not_nil
    refute_nil @vtt_file
  end

  def test_that_vtt_file_has_lines
    refute_nil @vtt_file.lines
  end

  def test_that_vtt_file_is_instance_of_vtt_file
    assert_instance_of VTTFile, @vtt_file
  end

  def test_that_vtt_file_has_at_least_one_line
    assert @vtt_file.lines.count >= 1
  end
end
