require_relative 'record'
require_relative 'records/head'
require_relative 'records/family'
require_relative 'records/person'
require_relative 'records/note'
require_relative 'records/multimedia'
require_relative 'records/source'
require_relative 'records/submission'

class RecordFactory
    @records_map = {}

    def self.make(line)
        level    = line.first
        id       = line.third.nil? ? nil         : line.second
        type     = line.third.nil? ? line.second : line.third
        value    = line.third.nil? ? nil         : line.fourth

        begin
            return create_instance(level, id, type, value)
        rescue StandardError => e
            raise "Do not know how to make a #{type} record: #{e}"
        end
    end

    def self.create_instance(level, id, type, value)
        return nil if type == 'TRLR'

        class_to_instantiate = @records_map[type]
        return class_to_instantiate.new(level, id, type, value)
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
