require_relative '../record_decorator'

class Source < RecordDecorator
    def title
        @title ||= @reference.find('TITL')
        return @title
    end

    def text
        @text ||= @reference.find('TEXT')
        return @text
    end

    def multimedia
        @multimedia ||= @reference.find_all('OBJE')
        return @multimedia
    end
end
