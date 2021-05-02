class NullPerson
    attr_reader :num_families
    attr_writer :parents

    @next_id = 100_000

    def initialize(family)
        @id = NullPerson.next_id
        @family = family
        @num_families = 1
        @parents = nil
    end

    def self.next_id
        @next_id += 1
        return @next_id - 1
    end

    def id
        return "@NI00#{@id}"
    end

    def short_id
        return @id
    end

    def first_name
        return 'Null'
    end

    def last_name
        return 'Person'
    end

    def value
        return "#{first_name} #{last_name}"
    end

    def sosa
        return ''
    end

    def birth
        return ''
    end

    def gender
        return ''
    end

    def siblings
        return []
    end

    def parents
        return @parents.nil? ? [] : [@parents]
    end

    def father
        return nil
    end

    def mother
        return nil
    end

    def events
        return EventList.new
    end

    def sources
        return nil
    end

    def avatar
        return nil
    end

    def families
        return [@family]
    end

    def ==(other)
        return id == other.id
    end

    def main?
        return true
    end
end
