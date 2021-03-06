require_relative '../record_decorator'
require_relative '../null_person'

class Family < RecordDecorator
    attr_reader :type

    def initialize(record)
        super(record)
        @type = 'Family'
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

    def person?(person)
        return spouses.any? { |spouse| spouse.id == person.id }
    end

    def husband
        @husband ||= find('HUSB') || NullPerson.new(self)
        return @husband
    end

    def wife
        @wife ||= find('WIFE') || NullPerson.new(self)
        return @wife
    end

    def other_spouse(spouse)
        is_husband = husband.id == spouse.id
        other = is_husband ? wife : husband
        return other
    end

    def children
        @children ||= find_all('CHIL')
        return @children
    end

    def siblings
        siblings = []
        persons.each do |person|
            siblings.concat(person.siblings)
        end
        return siblings
    end

    def parents
        return spouses.map(&:parents).flatten
    end

    def events
        @events ||= find_events(@family_event_tags)
        return @events
    end
end
