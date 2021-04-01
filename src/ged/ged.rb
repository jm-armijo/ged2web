require_relative 'record_factory'

class Ged
    attr_reader :path
    attr_reader :records

    def initialize(gedcom_path)
        @path = File.expand_path(gedcom_path)
        @dir = File.dirname(@path)

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

    def update_paths
        @records.each_value do |record|
            record.update_paths(@dir)
        end
    end
end
