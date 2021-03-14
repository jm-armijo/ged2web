class Record
    attr_reader :id
    attr_reader :type
    attr_reader :level
    attr_reader :value

    def initialize(level, id, type, value)
        @level = level
        @id    = id
        @type  = type
        @value = value

        @entries = []
        @current = nil
    end

    def add(entity)
        level = entity.record.level

        if @level == level - 1
            @current = entity
            @entries.push(@current)
        else
            @current.record.add(entity)
        end
    end

    def resolve_pointers(all_entries)
        @entries.each_with_index do |entry, index|
            # Replace current "entity" object with its decoractor class
            @entries[index] = all_entries[entry.id] if !entry.id.nil?

            # Resolve references for children records
            entry.record.resolve_pointers(all_entries)
        end
    end

    def find(type)
        return @entries.find { |entry| entry.type == type }
    end

    def find_all(type)
        return @entries.find_all { |entry| entry.type == type }
    end
end
