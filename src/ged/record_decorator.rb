require_relative 'record'

class RecordDecorator < Record
    def id
        return @line.id
    end

    def tag
        return @line.tag
    end

    def value
        return @line.value
    end

    def short_id
        return id.sub(/^@\w0*(\d+)@/, '\1')
    end

    def references
        return find_all('SOUR')
    end

    def notes
        return find_all('NOTE')
    end

    def to_s
        return value || ''
    end

    def to_str
        return to_s
    end
end
