require_relative 'record'
require_relative 'entities/head'
require_relative 'entities/family'
require_relative 'entities/person'
require_relative 'entities/note'
require_relative 'entities/multimedia'
require_relative 'entities/source'
require_relative 'entities/submission'
require_relative 'entities/event'

class EntityFactory
    @entities_map = {}

    def self.make(line)
        return create_instance(line)
    rescue StandardError => e
        raise "Do not know how to make a #{line.tag} record: #{e}"
    end

    def self.create_instance(line)
        return nil if line.tag == 'TRLR'

        if @entities_map.include?(line.tag)
            class_to_instantiate = @entities_map[line.tag]
        else
            class_to_instantiate = Entity
        end

        record = Record.new(line.level, line.id, line.tag, line.value)
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

EntityFactory.register('BIRT', Event)
EntityFactory.register('ADOP', Event)
EntityFactory.register('BAPM', Event)
EntityFactory.register('BAPL', Event)
EntityFactory.register('BARM', Event)
EntityFactory.register('BASM', Event)
EntityFactory.register('BLES', Event)
EntityFactory.register('CHR',  Event)
EntityFactory.register('CONF', Event)
EntityFactory.register('CHRA', Event)
EntityFactory.register('EMIG', Event)
EntityFactory.register('FCOM', Event)
EntityFactory.register('GRAD', Event)
EntityFactory.register('IMMI', Event)
EntityFactory.register('NATU', Event)
EntityFactory.register('ORDN', Event)
EntityFactory.register('RETI', Event)
EntityFactory.register('WILL', Event)
EntityFactory.register('EVEN', Event)
EntityFactory.register('CENS', Event)
EntityFactory.register('DEAT', Event)
EntityFactory.register('BURI', Event)
EntityFactory.register('CREM', Event)
EntityFactory.register('PROB', Event)
