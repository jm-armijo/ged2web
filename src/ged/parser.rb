require_relative 'ged'
require_relative 'line'

class Parser
    def initialize
        @current_record = nil
    end

    def parse(gedcom_path)
        path = File.expand_path(gedcom_path)
        dir = File.dirname(path)

        # Load all records into an instance of the corresponding class
        ged = process_file(path)

        # Records point to other records: resolving pointers so data can
        # be accessed.
        resolve_pointers(ged)

        update_paths(ged, dir)

        # Add a pointer from a source to the persons that use it
        link_records(ged)

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

    def link_records(ged)
        link_persons_to_sources(ged)
        link_sources_to_objects(ged)
    end

    def link_persons_to_sources(ged)
        ged.persons.each_value do |person|
            link_person_to_sources(person)
        end
    end

    def link_sources_to_objects(ged)
        ged.sources.each_value do |source|
            link_source_to_objects(source)
        end
    end

    def link_person_to_sources(person)
        person.sources.each do |source|
            source.link_person(person)
        end
    end

    def link_source_to_objects(source)
        source.multimedia.each do |object|
            object.link_source(source)
        end
    end
end
