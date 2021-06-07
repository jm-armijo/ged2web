require_relative '../record_decorator'

class Source < RecordDecorator
    def initialize(line)
        super(line)
        @persons = []
    end

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

    def link_person(person)
        @persons.push(person)
        @persons.uniq!(&:id)
    end

    def referenced_alive?
        return @persons.any?(&:alive?)
    end
end
