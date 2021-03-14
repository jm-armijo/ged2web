class Entity
    attr_accessor :record

    def initialize(record)
        @record = record
    end

    def id
        return @record.id
    end

    def type
        return @record.type
    end

    def value
        return @record.value
    end

    def references
        return @record.find_all('SOUR')
    end

    def notes
        return @record.find_all('NOTE')
    end

    def find(type)
        return @record.find(type)
    end

    def find_all(type)
        return @record.find_all(type)
    end

    def to_s
        return @record.value || ''
    end

    def to_str
        return to_s
    end
end
