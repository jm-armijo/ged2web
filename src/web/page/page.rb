class Page
    attr_reader :data
    attr_reader :language
    attr_reader :styles
    attr_reader :languages

    def initialize(data, language, styles, languages)
        @data      = data
        @language  = language
        @styles    = styles
        @languages = languages
    end
end
