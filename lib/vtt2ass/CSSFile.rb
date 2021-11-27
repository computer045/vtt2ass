require 'css_parser'
require_relative 'CSSRule'

class CSSFile
    attr_reader :rules
    include CssParser

    def initialize(file_path)
        @file_path = file_path
        parser = CssParser::Parser.new
        parser.load_file!(file_path)
        @rules = []
        parser.each_selector do |selector, declarations, specificity|
            css_obj = CSSRule.new(selector, declarations)
            if not css_obj.name.empty? then
                @rules.push(css_obj)
            end
        end
    end

    def find_rule(value)
        return_rule = nil
        @rules.each do |rule|
            if rule.name == value then
                return_rule = rule
                break
            end
        end
        return return_rule
    end

    def to_s
        return @file_path
    end

end