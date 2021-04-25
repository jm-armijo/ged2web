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
            parents.concat(node.parents)
        end
        return parents
    end

    def add_families(families)
        families.each do |family|
            next if family.nil?

            nodes = family.spouses.map(&:families).flatten
            @nodes.concat(nodes)
        end

        @nodes.uniq!(&:id)
    end
end
