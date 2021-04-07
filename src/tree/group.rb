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

    def persons
        return [@person]
    end

    def children
        return []
    end

    def parents
        parents = []
        parents.push(@person.father) if !@person.father.nil?
        parents.push(@person.mother) if !@person.mother.nil?
        return parents
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

    def persons
        persons = []
        @families.each do |family|
            persons.concat(family.spouses) if !family.spouses.nil?
        end
        return persons
    end

    def children
        children = []
        @families.each do |family|
            children.concat(family.children)
        end
        return children
    end

    def parents
        parents = []
        persons.each do |person|
            parents.push(person.father) if !person.father.nil?
            parents.push(person.mother) if !person.mother.nil?
        end
        return parents
    end
end
