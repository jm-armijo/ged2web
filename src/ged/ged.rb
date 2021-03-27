require_relative 'entity_factory'

class Ged
    attr_reader :entities

    def initialize
        @entities = {}
        @current_entity = nil
    end

    def add(line)
        if line.level.zero?
            create_root_entity(line)
        else
            create_child_entity(line)
        end
    end

    def resolve_pointers
        @entities.each_value do |entity|
            entity.record.resolve_pointers(@entities)
        end
    end

private

    def create_root_entity(line)
        entity = EntityFactory.make(line)

        return if entity.nil?

        @current_entity = entity
        id = @current_entity.id
        @entities[id] = @current_entity
    end

    def create_child_entity(line)
        entity = EntityFactory.make(line)
        @current_entity.record.add(entity)
    end
end
