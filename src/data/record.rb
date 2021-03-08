require_relative 'entry'

class Record < Entry
    attr_reader :id
    attr_reader :type
    attr_reader :value

    def initialize(line)
        super
        init(line)
    end

    def init(line)
        @level    = line.first
        @id       = line.third.nil? ? nil         : line.second
        @type     = line.third.nil? ? line.second : line.third
        @value    = line.third.nil? ? nil         : line.fourth
    end
end
