class PersonGroup
    def initialize
        @person = nil
    end

    def add(person)
        @person = person
    end

    def person?(person)
        return @person.id == person.id
    end
end

class FamilyGroup
    def initialize
        @families = []
    end

    def add(person)
        @families.concat(person.families)
    end

    def person?(person)
        return @families.any? do |family|
            family.spouse?(person)
        end
    end
end
