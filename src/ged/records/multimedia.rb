require_relative '../record_decorator'

class Multimedia < RecordDecorator
    def initialize(line)
        super(line)
        @sources = []
    end

    def url
        return "obj/#{short_id}.#{format}"
    end

    def file
        return find('FILE') || ''
    end

    def format
        return find('FILE')&.find('FORM') || ''
    end

    def title
        return find('FILE')&.find('TITL') || ''
    end

    def link_source(source)
        @sources.push(source)
        @sources.uniq!(&:id)
    end

    def referenced_alive?
        return @sources.any?(&:referenced_alive?)
    end
end
