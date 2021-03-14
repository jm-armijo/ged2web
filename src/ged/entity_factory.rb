require_relative 'record'
require_relative 'entities/head'
require_relative 'entities/family'
require_relative 'entities/person'
require_relative 'entities/note'
require_relative 'entities/multimedia'
require_relative 'entities/source'
require_relative 'entities/submission'

class EntityFactory
    @entities_map = {}

    def self.make(level, id, type, value)
        begin
            return create_instance(level, id, type, value)
        rescue StandardError => e
            raise "Do not know how to make a #{type} record: #{e}"
        end
    end

    def self.create_instance(level, id, type, value)
        return nil if type == 'TRLR'

        if @entities_map.include? (type)
            class_to_instantiate = @entities_map[type]
        else
            class_to_instantiate = Entity
        end

        record = Record.new(level, id, type, value)
        return class_to_instantiate.new(record)
    end

    def self.register(record_type, class_to_instantiate)
        @entities_map[record_type] = class_to_instantiate
    end
end

EntityFactory.register('HEAD', Head)
EntityFactory.register('FAM',  Family)
EntityFactory.register('INDI', Person)
EntityFactory.register('NOTE', Note)
EntityFactory.register('OBJE', Multimedia)
EntityFactory.register('SOUR', Source)
EntityFactory.register('SUBM', Submission)
