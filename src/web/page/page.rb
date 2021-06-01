class Page
    attr_reader :data
    attr_reader :styles

    def initialize(data, styles)
        @data = data
        @styles = styles
    end
end
