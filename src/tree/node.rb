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

class Node
private

    def set_parents
        @parents = []
        persons.each do |person|
            if !person.parents.nil?
                @parents.push(person.parents)
            elsif person.main?
                @parents.push(NullFamily.new(self))
            end
        end
    end
end

class PersonNode < Node
    attr_reader :parents

    def initialize(person)
        super()
        @person = person
        set_parents
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

class FamilyNode < Node
    attr_reader :parents

    def initialize(family)
        super()
        @family = family
        set_parents
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
