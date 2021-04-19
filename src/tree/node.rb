class NodesFactory
    def self.make(person)
        if person.num_families.positive?
            nodes = person.families.map do |family|
                FamilyNode.new(family)
            end
        else
            nodes = [PersonNode.new(person)]
        end

        return nodes
    end
end

class PersonNode
    def initialize(person)
        @person = person
    end

    def id
        return @person.id
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

class FamilyNode
    def initialize(family)
        @family = family
    end

    def id
        return @family.id
    end

    def person?(person)
        @family.spouse?(person)
    end

    def persons
        persons = []
        persons.concat(@family.spouses)
        return persons.uniq(&:id)
    end

    def children
        children = []
        children.concat(@family.children)
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
