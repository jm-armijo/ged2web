require_relative 'event'

class NilEvent < Event
    def initialize
        super('')
        @date = GedDate.new(nil)
        @place = nil
    end

    def nil?
        return true
    end
end
