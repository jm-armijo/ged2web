require_relative 'entity_factory'

class Ged
    attr_reader :entities

    def initialize
        @entities = {}
        @current_entity = nil
    end

    def add(line)
        level = line.first
        if level.zero?
            entity = create_root_entity(line)
            return if entity.nil?

            @current_entity = entity
            id = @current_entity.record.id
            @entities[id] = @current_entity
        else
            entity = create_new_child_entity(line)
            @current_entity.record.add(entity)
        end
    end

    def resolve_pointers
        @entities.each_value do |entity|
            entity.record.resolve_pointers(@entities)
        end
    end

    def create_root_entity(line)
        level    = line.first
        id       = line.third.nil? ? nil         : line.second
        type     = line.third.nil? ? line.second : line.third
        value    = line.third.nil? ? nil         : line.fourth

        return EntityFactory.make(level, id, type, value)
    end

    def create_new_child_entity(line)
        level    = line.first
        type     = line.second
        value    = line.third&.match(/^@.*@$/) ? nil        : line.third
        id       = line.third&.match(/^@.*@$/) ? line.third : nil

        return EntityFactory.make(level, id, type, value)
    end
end
