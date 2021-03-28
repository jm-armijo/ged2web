require_relative 'record'
require_relative 'records/head'
require_relative 'records/family'
require_relative 'records/person'
require_relative 'records/pointer'
require_relative 'records/note'
require_relative 'records/multimedia'
require_relative 'records/source'
require_relative 'records/submission'
require_relative 'records/event'

class RecordFactory
    @records_map = {}

    def self.make(line)
        return create_instance(line)
    rescue StandardError => e
        raise "Do not know how to make a #{line.tag} record: #{e}"
    end

    def self.create_instance(line)
        if @records_map.include?(line.tag)
            class_to_instantiate = @records_map[line.tag]
        else
            class_to_instantiate = RecordDecorator
        end

        return class_to_instantiate.new(line)
    end

    def self.register(record_type, class_to_instantiate)
        @records_map[record_type] = class_to_instantiate
    end
end

RecordFactory.register('HEAD', Head)
RecordFactory.register('FAM',  Family)
RecordFactory.register('INDI', Person)
RecordFactory.register('NOTE', Note)
RecordFactory.register('OBJE', Multimedia)
RecordFactory.register('SOUR', Source)
RecordFactory.register('SUBM', Submission)

RecordFactory.register('BIRT', Event)
RecordFactory.register('ADOP', Event)
RecordFactory.register('BAPM', Event)
RecordFactory.register('BAPL', Event)
RecordFactory.register('BARM', Event)
RecordFactory.register('BASM', Event)
RecordFactory.register('BLES', Event)
RecordFactory.register('CHR',  Event)
RecordFactory.register('CONF', Event)
RecordFactory.register('CHRA', Event)
RecordFactory.register('EMIG', Event)
RecordFactory.register('FCOM', Event)
RecordFactory.register('GRAD', Event)
RecordFactory.register('IMMI', Event)
RecordFactory.register('NATU', Event)
RecordFactory.register('ORDN', Event)
RecordFactory.register('RETI', Event)
RecordFactory.register('WILL', Event)
RecordFactory.register('EVEN', Event)
RecordFactory.register('CENS', Event)
RecordFactory.register('DEAT', Event)
RecordFactory.register('BURI', Event)
RecordFactory.register('CREM', Event)

RecordFactory.register('FAMS', Pointer)
RecordFactory.register('FAMC', Pointer)
RecordFactory.register('PROB', Event)
RecordFactory.register('ANUL', Event)
RecordFactory.register('CENS', Event)
RecordFactory.register('DIV',  Event)
RecordFactory.register('DIVF', Event)
RecordFactory.register('ENGA', Event)
RecordFactory.register('MARB', Event)
RecordFactory.register('MARC', Event)
RecordFactory.register('MARR', Event)
RecordFactory.register('MARL', Event)
RecordFactory.register('MARS', Event)
RecordFactory.register('RESI', Event)

RecordFactory.register('HUSB', Pointer)
RecordFactory.register('WIFE', Pointer)
