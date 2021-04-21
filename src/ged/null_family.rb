class NullFamily
    attr_reader :husband
    attr_reader :wife
    attr_reader :children
    attr_reader :events

    @next_id = 100_000

    def initialize(child)
        @id = NullFamily.next_id
        @husband = NullPerson.new(self)
        @wife = NullPerson.new(self)
        @children = [child]
        @events = []
    end

    def self.next_id
        @next_id += 1
        return @next_id - 1
    end

    def id
        return "@NFAM000#{@id}"
    end

    def short_id
        return @id
    end

    def spouses
        return [@husband, @wife]
    end
end
