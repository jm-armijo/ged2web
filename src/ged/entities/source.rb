require_relative '../entity'

class Source < Entity
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
