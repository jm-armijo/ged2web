require_relative 'record'

class Ged
    attr_reader :records

    def initialize
        @records = {}
        @current_record = nil
    end

    def add(line)
        level = line.first
        if level.zero?
            @current_record = Record.new(line)
            @records[@current_record.id] = @current_record
        else
            @current_record.add(line)
        end
    end

    def resolve_dependencies
        @records.each_value do |record|
            record.resolve_dependencies(@records)
        end
    end
end
