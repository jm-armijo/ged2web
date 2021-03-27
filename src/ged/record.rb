class Record
    attr_writer :reference

    def initialize(line)
        @line = line
        @records = []
    end

    def add(new_line)
        if @line.level == new_line.level - 1
            record = RecordFactory.make(new_line)
            @records.push(record)
        else
            @records.last.add(new_line)
        end
    end

    def resolve_pointers(all_records)
        @records.each_with_index do |record, index|
            # Replace current "record" object with its decoractor class
            @records[index].reference = all_records[record.id] if !record.id.nil?

            # Resolve references for children records
            record.resolve_pointers(all_records)
        end
    end

    def find(tag)
        return @records.find { |record| record.tag == tag }
    end

    def find_all(tag)
        return @records.find_all { |record| record.tag == tag }
    end

    def deep_find_all(tag)
        records_found = find_all(tag)

        @records.each do |record|
            records_found.concat(record.find_all(tag))
        end

        return records_found.uniq.sort { |a, b| a.short_id <=> b.short_id }
    end
end
