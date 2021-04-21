class Generation
    attr_reader :nodes

    def initialize
        @nodes = []
    end

    def add(node)
        @nodes.push(node)
    end
end
