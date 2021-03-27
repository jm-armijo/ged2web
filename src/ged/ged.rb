require_relative 'record_factory'

class Ged
    attr_reader :records

    def initialize
        @records = {}
        @current_record = nil
    end

    def add(line)
        if line.level.zero?
            @current_record = RecordFactory.make(line)
            @records[line.id] = @current_record
        else
            @current_record.add(line)
        end
    end

    def resolve_pointers
        @records.each_value do |record|
            record.resolve_pointers(@records)
        end
    end
end
