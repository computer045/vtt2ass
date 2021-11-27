class CSSRule
    attr_reader :name, :properties

    def initialize(selector, declarations)
        @name = reduce_selector(selector)
        declarations.split(/;\s?/).each do |dec|
            @properties = []
            temp = dec.split(/:\s?/)
            @properties.push(
                { key: temp.first, value: temp.last}
            )
        end
    end

    def to_s
        return "#{@name} #{@properties}"
    end

    def reduce_selector(selector)
        return selector.to_s.gsub(/\.rmp-container>\.rmp-content>\.rmp-cc-area>\.rmp-cc-container>\.rmp-cc-display>\.rmp-cc-cue\s?\.?/, '')
    end
end