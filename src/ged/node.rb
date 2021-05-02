class Node
    def self.persons(node)
        return node.respond_to?('persons') ? node.persons : [node]
    end

    def self.ids(node)
        id = node.id
        return id.is_a?(Array) ? id : [id]
    end

    def self.compare(node1, node2)
        return true if node2.nil?
        return false if node1.nil?

        birth1 = persons(node1).first.birth
        birth2 = persons(node2).first.birth

        date1 = birth1 == '' ? '' : birth1.date.to_s
        date2 = birth2 == '' ? '' : birth2.date.to_s

        return date1 < date2
    end

    def self.intersect?(node1, node2)
        node1.persons.each do |person|
            return true if node2.persons.map(&:id).include?(person.id)
        end

        return false
    end

    def self.create_dummy_parents(node)
        persons(node).each do |person|
            person.parents = NullFamily.new(person) if person.parents.length.zero? && person.main?
        end
    end

    # Group related nodes into one group.
    # Pre-conditions:
    # - "nodes" is a non empty array
    # Post-conditions:
    # - The length of "nodes" is reduced by n
    # - The returned group has n nodes
    def self.group_related_nodes(nodes)
        # Pick up the first node
        base_node = nodes.shift
        merged = [base_node]

        # Merge any other node that intersects the previous node
        num_nodes = nodes.length
        (0..num_nodes - 1).each do |_i|
            node = nodes.shift
            intersect?(base_node, node) ? merged.push(node) : nodes.push(node)
        end

        # Create a merged node
        return Group.new(merged)
    end
end
