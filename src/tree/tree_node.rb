class TreeNode
    def initialize
        @nodes = []
    end

    def add(node)
        @nodes.push(node)
    end

    def add_from_list(list)
        @nodes.concat(list)
        @nodes.uniq!
    end

    def length
        return @nodes.length
    end

    def persons
        persons = []
        @nodes.each do |node|
            if node.respond_to?('persons')
                persons.concat(node.persons)
            else
                persons.push(node)
            end
        end

        return persons.uniq
    end
end
