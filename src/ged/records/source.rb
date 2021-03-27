require_relative '../record_decorator'

class Source < RecordDecorator
    def title
        @title ||= find('TITL')
        return @title
    end

    def text
        @text ||= find('TEXT')
        return @text
    end

    def multimedia
        @multimedia ||= find_all('OBJE')
        return @multimedia
    end
end
