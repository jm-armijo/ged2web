class Page
    attr_reader :data
    attr_reader :language
    attr_reader :styles

    def initialize(data, language, styles)
        @data     = data
        @language = language
        @styles   = styles
    end
end
