class Record
    attr_reader :id
    attr_reader :type
    attr_reader :value

    def initialize(level, id, type, value)
        @level = level
        @id    = id
        @type  = type
        @value = value

        @entries = []
        @current = nil
    end

    def add(line)
        level = line.first

        if @level == level - 1
            @current = create_new_child_record(line)
            @entries.push(@current)
        else
            @current.add(line)
        end
    end

    def resolve_references(records)
        @entries.each_with_index do |entry, index|
            # Replace current "record" object with its decoractor class
            @entries[index] = records[entry.id] if !entry.id.nil?

            # Resolve references for children records
            entry.resolve_references(records)
        end
    end

    def find(type)
        return @entries.find { |entry| entry.type == type }
    end

    def find_all(type)
        return @entries.find_all { |entry| entry.type == type }
    end

private

    def create_new_child_record(line)
        level    = line.first
        type     = line.second
        value    = line.third&.match(/^@.*@$/) ? nil        : line.third
        id       = line.third&.match(/^@.*@$/) ? line.third : nil

        return Record.new(level, id, type, value)
    end
end
