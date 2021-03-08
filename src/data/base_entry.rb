require_relative 'ged'

class BaseEntry
    attr_reader :entries
    attr_accessor :instance

    def initialize
        @instance = nil
        @entries = []
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
