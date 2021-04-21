require_relative '../ged/null_family'

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
    attr_reader :parents

    def initialize(person)
        @person = person

        @parents = []
        @parents.push(person.parents || NullFamily.new(self))
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
end

class FamilyNode
    attr_reader :parents

    def initialize(family)
        @family = family

        @parents = []
        persons.each do |person|
            @parents.push(person.parents || NullFamily.new(self))
        end
    end

    def id
        return @family.id
    end

    def person?(person)
        @family.spouse?(person)
    end

    def persons
        return @family.spouses
    end

    def children
        children = []
        children.concat(@family.children)
        return children
    end
end
