require_relative '../ged/null_family'
require_relative '../ged/group'

class Generation
    attr_reader :nodes

    def initialize
        @nodes = []
        @num_groups = 0
    end

    def add(node)
        @nodes.push(node)
    end

    def parents
        parents = []
        @nodes.each do |node|
            persons(node).each do |person|
                person.parents = NullFamily.new(person) if person.parents.length.zero?
            end
            parents.concat(node.parents)
        end
        return parents.uniq(&:id)
    end

    def add_families(families)
        families.each do |family|
            nodes = family.spouses.map(&:families).flatten
            @nodes.concat(nodes)
        end

        @nodes.uniq!(&:id)
    end

    def group_nodes
        nodes = nodes_to_group
        remainder = @nodes - nodes

        grouped_nodes = []
        while nodes.length.positive?
            group = group_related_nodes(nodes)
            grouped_nodes.push(group)
        end

        @nodes = remainder + grouped_nodes
    end

    # Keep the order of primary nodes unchanged.
    # Sort secondary nodes
    def sort(parents)
        primary_nodes = get_primary_nodes(parents)
        secondary_nodes = @nodes - primary_nodes

        @nodes = primary_nodes + secondary_nodes
    end

private

    def get_primary_nodes(parents)
        return parents if @nodes.length == parents.length && @num_groups.zero?

        primary_nodes = []
        parents.each do |parent|
            index = @nodes.find_index { |node| ids(node).include?(parent.id) }
            if !index.nil?
                primary_nodes.push(@nodes[index])
                @nodes.delete_at(index)
            end
        end

        return primary_nodes.uniq
    end

    def get_secondary_nodes(primary_nodes)
        secondary_nodes = []

        # Expects that if the two lists have different length they should not have
        # exactly the same nodes, so we need to find the differences.
        if @nodes.length > primary_nodes.length
            family_ids = primary_nodes.map(&:id)
            secondary_nodes = @nodes.reject { |node| family_ids.include?(node.id) }
        end
        return secondary_nodes
    end

    def nodes_to_group
        nodes_to_group = []
        @nodes.each do |node|
            persons(node).each do |person|
                nodes_to_group.concat(person.families.map(&:id)) if person.families.length > 1
            end
        end

        nodes_to_group.uniq!

        return @nodes.select { |node| nodes_to_group.include?(node.id) }
    end

    # Group related nodes into one group.
    # Pre-conditions:
    # - "nodes" is a non empty array
    # Post-conditions:
    # - The length of "nodes" is reduced by n
    # - The returned group has n nodes
    def group_related_nodes(nodes)
        # Pick up the first node
        base_node = nodes.shift
        merged = [base_node]

        # Merge any other node that intersects the previous node
        num_nodes = nodes.length
        (0..num_nodes - 1).each do |_i|
            node = nodes.shift
            nodes_intersect?(base_node, node) ? merged.push(node) : nodes.push(node)
        end

        # Create a merged node
        @num_groups += 1
        return Group.new(merged)
    end

    def persons(node)
        return node.respond_to?('persons') ? node.persons : [node]
    end

    def nodes_intersect?(node1, node2)
        node1.persons.each do |person|
            return true if node2.persons.map(&:id).include?(person.id)
        end

        return false
    end

    def ids(node)
        id = node.id
        return id.is_a?(Array) ? id : [id]
    end
end
