class NullFamily
    attr_reader :husband
    attr_reader :wife
    attr_reader :children
    attr_reader :events
    attr_reader :type

    @next_id = 1

    def initialize(child)
        @id = NullFamily.next_id
        @husband = NullPerson.new(self)
        @wife = NullPerson.new(self)
        @children = [child]
        @events = []
        @type = 'Family'
    end

    def self.next_id
        @next_id += 1
        return @next_id - 1
    end

    def id
        return "@NF00#{@id}@"
    end

    def short_id
        return @id
    end

    def siblings
        return []
    end

    def persons
        return spouses
    end

    def person?(person)
        return spouses.any? { |spouse| spouse.id == person.id }
    end

    def spouses
        return [@husband, @wife]
    end

    def parents
        return spouses.map(&:parents).flatten
    end
end
