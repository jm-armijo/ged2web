class Record
    attr_accessor :reference
    attr_writer   :value

    def initialize(line)
        @line = line
        @records = []
        @value = nil
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

    def find_sources(depth = 0)
        # Jump into one reference only to avoid circular dependency.
        # Also exclude FAMC as we want to skip too many details about ancestors (they
        # will be shown on the corresponding pages for the ancestor)
        if depth == 2 || @line.tag == 'FAMC'
            records_found = []
        else
            records_found = deep_find_sources(depth)
        end

        return records_found.uniq(&:short_id).sort { |a, b| a.short_id <=> b.short_id }
    end

    def update_paths(base_dir)
        files = find_all('FILE')
        files.each do |file|
            file.value = File.join(base_dir, file.value)
        end
    end

private

    def deep_find_sources(depth)
        tag = 'SOUR'

        records_found = find_all(tag)

        # Recursivelly check next reference: increase depth
        records_found.concat(reference.find_sources(depth + 1)) if !reference.nil?

        @records.each do |record|
            # Check nested record: pass current depth
            records_found.concat(record.find_sources(depth))
        end

        return records_found
    end
end
