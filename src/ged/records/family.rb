require_relative '../record_decorator'
require_relative '../null_person'

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

    def spouse?(person)
        return true if husband&.id == person.id
        return true if wife&.id == person.id

        return false
    end

    def spouses
        spouses = []
        spouses.push(husband) if !husband.nil?
        spouses.push(wife) if !wife.nil?
        return spouses
    end

    def persons
        return spouses
    end

    def husband
        @husband ||= find('HUSB') || NullPerson.new(self)
        return @husband
    end

    def wife
        @wife ||= find('WIFE') || NullPerson.new(self)
        return @wife
    end

    def children
        @children ||= find_all('CHIL')
        return @children
    end

    def parents
        return spouses.map(&:parents).flatten
    end

    def events
        @events ||= find_events(@family_event_tags)
        return @events
    end
end
