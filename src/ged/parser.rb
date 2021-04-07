require_relative 'ged'
require_relative 'line'

class Parser
    def initialize
        @current_record = nil
    end

    def parse(gedcom_path)
        path = File.expand_path(gedcom_path)
        dir = File.dirname(path)

        ged = process_file(path)
        resolve_pointers(ged)
        update_paths(ged, dir)

        return ged
    end

private

    def process_file(path)
        ged = Ged.new

        File.foreach(path) do |raw_line|
            line = Line.new(raw_line)
            add(ged, line)
        end

        return ged
    end

    def add(ged, line)
        if line.level.zero?
            @current_record = RecordFactory.make(line)
            ged.add_record(line.id, @current_record)
        else
            @current_record.add(line)
        end
    end

    def resolve_pointers(ged)
        ged.records.each_value do |record|
            record.resolve_pointers(ged.records)
        end
    end

    def update_paths(ged, dir)
        ged.records.each_value do |record|
            record.update_paths(dir)
        end
    end
end
