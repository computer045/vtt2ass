# frozen_string_literal: true

require 'test_helper'

class CSSFileTest < Minitest::Test
  def setup
    fixtures_path = "#{__dir__}/fixtures/"
    css_file_path = "#{fixtures_path}Cute_Executive_Officer_Episode_1.Eng.css"
    @css_file = CSSFile.new(css_file_path)
  end

  def test_css_file_not_nil
    refute_nil @css_file
  end

  def test_instance_of_css_file
    assert_instance_of CSSFile, @css_file
  end
end
