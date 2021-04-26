require_relative '../ged/null_family'

class Generation
    attr_reader :nodes

    def initialize
        @nodes = []
    end

    def add(node)
        @nodes.push(node)
    end

    def parents
        parents = []
        @nodes.each do |node|
            persons = node.respond_to?('persons') ? node.persons : [node]
            persons.each do |person|
                person.parents = NullFamily.new(person) if person.parents.length.zero?
            end
            parents.concat(node.parents)
        end
        return parents
    end

    def add_families(families)
        families.each do |family|

            nodes = family.spouses.map(&:families).flatten
            @nodes.concat(nodes)
        end

        @nodes.uniq!(&:id)
    end
end
