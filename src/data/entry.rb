require_relative 'ged'

class Entry
    attr_reader :entries
    attr_accessor :instance
    attr_reader :value

    def initialize(line)
        @instance = nil
        @entries = []

        init(line)
    end

    def init(line)
        @level    = line.first
        @type     = line.second
        @value    = line.third
    end

    def add(line)
        if @level == line.first - 1
            @current_entry = Entry.new(line)
            @entries.push(@current_entry)
        else
            @current_entry.add(line)
        end
    end

    def resolve_dependencies(records)
        @entries.each do |entry|
            entry.instance = records[entry.value] if entry.value&.match(/^@.*@$/)
            entry.resolve_dependencies(records)
        end
    end
end
