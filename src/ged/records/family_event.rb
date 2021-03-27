require_relative '../record_decorator'

class FamilyEvent < RecordDecorator
    def husband
        return @reference.husband
    end

    def wife
        return @reference.wife
    end

    def events
        return @reference.events
    end
end
