require_relative 'record_factory'

class Ged
    attr_reader :records

    def initialize
        @records = {}
        @current_record = nil
    end

    def add(line)
        level = line.first
        if level.zero?
            @current_record = RecordFactory.make(line)
            @records[@current_record.id] = @current_record if !@current_record.nil?
        else
            @current_record.add(line)
        end
    end

    def resolve_references
        @records.each_value do |record|
            record.resolve_references(@records)
        end
    end
end
