class Group
    attr_reader :nodes
    attr_reader :type

    def initialize(nodes)
        @nodes = nodes
        @type = 'Group'
    end

    def include?(node)
        return @nodes.any? { |n| n.id == node.id }
    end

    def id
        return @nodes.map(&:id)
    end

    def person?(person)
        return @nodes.map { |node| node.spouse?(person) }
    end

    def persons
        return @nodes.map(&:persons).flatten
    end

    def parents
        return @nodes.map(&:parents).flatten
    end

    def siblings
        return @nodes.map(&:siblings).flatten
    end
end
