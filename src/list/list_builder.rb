class ListBuilder
    def initialize
        @nodes = []
        @generations = {}
        @nodes_map = {}
    end

    def make(ged)
        @nodes = ged.persons.values.clone
        @nodes.sort_by! { |node| [(node.last_name || '~').upcase, (node.first_name || '~').upcase] }

        return @nodes
    end
end
