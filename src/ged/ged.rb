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

    def persons
        return filter('INDI')
    end

    def objects
        return filter('OBJE')
    end

    def sources
        return filter('SOUR')
    end

private

    def filter(tag)
        return @records.filter { |_k, v| v.tag == tag }
    end
end
