require_relative '../record_decorator'

class Family < RecordDecorator
    def initialize(record)
        super(record)
        @family_event_tags = [
            'ANUL',
            'CENS',
            'DIV',
            'DIVF',
            'ENGA',
            'MARB',
            'MARC',
            'MARR',
            'MARL',
            'MARS',
            'RESI'
        ]
    end

    def husband
        @husband ||= find('HUSB')
        return @husband
    end

    def wife
        @wife ||= find('WIFE')
        return @wife
    end

    def events
        @events ||= find_events(@family_event_tags)
        return @events
    end
end
