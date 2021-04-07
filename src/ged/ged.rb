require_relative 'record_factory'
require_relative 'parser'

class Ged
    attr_reader :records

    def initialize
        @records = {}
    end

    def add_record(key, record)
        @records[key] = record
    end
end
