# frozen_string_literal: true

require 'css_parser'
require_relative 'css_rule'

##
# This class defines a CSS file for subtitles.
class CSSFile
  attr_reader :rules

  include CssParser

  def initialize(file_path)
    @file_path = file_path
    parser = CssParser::Parser.new
    parser.load_file!(file_path)
    @rules = []
    parser.each_selector do |selector, declarations, _specificity|
      css_obj = CSSRule.new(selector, declarations)
      @rules.push(css_obj) unless css_obj.name.empty?
    end
  end

  def find_rule(value)
    return_rule = nil
    @rules.each do |rule|
      if rule.name == value
        return_rule = rule
        break
      end
    end
    return_rule
  end

  def to_s
    @file_path
  end
end
