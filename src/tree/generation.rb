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
            parent_nodes = NodesFactory.make(family.husband)
            @nodes.concat(parent_nodes)
        end

        @nodes.uniq!(&:id)
    end
end
