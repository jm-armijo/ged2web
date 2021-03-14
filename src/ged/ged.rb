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
        arguments = root_arguments(line)
        entity = EntityFactory.make(*arguments)

        return if entity.nil?

        @current_entity = entity
        id = @current_entity.id
        @entities[id] = @current_entity
    end

    def create_child_entity(line)
        arguments = child_arguments(line)
        entity = EntityFactory.make(*arguments)
        @current_entity.record.add(entity)
    end

    def root_arguments(line)
        level    = line.first
        id       = line.third.nil? ? nil         : line.second
        type     = line.third.nil? ? line.second : line.third
        value    = line.third.nil? ? nil         : line.fourth

        return [level, id, type, value]
    end

    def child_arguments(line)
        level    = line.first
        type     = line.second
        value    = line.third&.match(/^@.*@$/) ? nil        : line.third
        id       = line.third&.match(/^@.*@$/) ? line.third : nil

        return [level, id, type, value]
    end
end
