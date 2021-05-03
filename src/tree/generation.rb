require_relative '../ged/null_family'
require_relative '../ged/group'
require_relative '../ged/node'
require_relative './placeholder'

class Generation
    attr_reader :nodes

    def initialize
        @nodes = []
        @num_groups = 0
    end

    def add(node)
        @nodes.push(node)
    end

    def add_families(families)
        families.each do |family|
            @nodes.concat(family.spouses.map(&:families).flatten)
        end

        @nodes.uniq!(&:id)
    end

    # Get the list of parents (family nodes) of the nodes in the current genaration.
    # Parents are returned in the same order held by their children.
    def parents
        parents = []
        @nodes.each do |node|
            # Some nodes have unknwon parents: creating dummies so we can leave
            # the space when drawing the tree.
            Node.create_dummy_parents(node)

            parents.concat(node.parents)
        end
        return parents.uniq(&:id)
    end

    # Creates group of families that have one common spouse.
    # Ex: Given 3 families (1) AB (2) BC (3) CD, all three families will be grouped.
    # Ex: Given 3 families (1) AB (2) BC (3) DE, only families 1, 2 will be grouped
    def group_nodes
        nodes = nodes_to_group
        remainder = @nodes - nodes
        grouped_nodes = Node.group_nodes(nodes)
        @num_groups += grouped_nodes.length
        @nodes = remainder + grouped_nodes
    end

    # Sort: implements the algorithm to sort a generation.
    #
    # Parent nodes of the next generation must respect the order of that generation,
    # given by argument "parents"
    #
    # Nodes that have no decendents in the next generation are sorted by date of birth,
    # without chaging the order of the other nodes.
    def sort(parents)
        # Get the primary nodes, and removes them from the @nodes list
        # Primary nodes are direct ancestors of nodes in the next generation.
        primary_nodes = get_primary_nodes(parents)

        # Any leftovers are secondary nodes
        # Secondary nodes are all other nodes that have no decendant in the next generation
        secondary_nodes = @nodes

        # If there aren't any secondary nodes it means all nodes are primary, and
        # we will keep the order that we already have.
        # Else, we still keep the order if the primary nodes, but sot the secondary
        # nodes around them.
        if secondary_nodes.length.zero?
            nodes = primary_nodes
        else
            nodes = sort_primary_and_secondary_nodes(primary_nodes, secondary_nodes)
        end

        # Removing any duplicated nodes. This can happen when iterating over
        # the primary nodes as siblings are counted twice.
        @nodes = nodes.uniq
    end

    def create_placehodlers
        current_index = 0

        while current_index < @nodes.length
            start_index = Node.find_first_null_family(@nodes, current_index)
            break if start_index.nil?

            end_index = Node.find_first_non_null_family(@nodes, start_index + 1) || @nodes.length

            # Remove Null Families from the nodes
            @nodes.slice!(start_index..end_index - 1)

            # Insert a placeholder instead with the number of replaced nodes
            placeholder = Placeholder.new(end_index - start_index)
            @nodes.insert(start_index, placeholder)

            # The length of @nodes has changed: continue were we left.
            current_index = start_index + 1
        end
    end

private

    def sort_primary_and_secondary_nodes(primary_nodes, secondary_nodes)
        # The sorted nodes will be added to this variable: initializing empty.
        nodes = []

        # For each primary node, find all related nodes
        primary_nodes.each do |primary_node|
            # For all siblings of the current primary node, find all secondary
            # nodes that contain the sibling
            secondary_siblings = Node.find_nodes_with_siblings(secondary_nodes, primary_node.siblings)
            secondary_nodes -= secondary_siblings

            # For all siblings of the current primary node, find all primary
            # nodes that contain the sibling
            primary_siblings = Node.find_nodes_with_siblings(primary_nodes, primary_node.siblings)
            primary_nodes -= primary_siblings

            # Sort the nodes
            nodes.concat(join_nodes(primary_node, primary_siblings, secondary_siblings))
        end

        # Any node that did not belong to any category is appended to the end
        nodes.concat(secondary_nodes)

        return nodes
    end

    def join_nodes(primary_node, primary_siblings, secondary_siblings)
        older_nodes   = secondary_siblings.select { |sibling| Node.compare(sibling, primary_node) }
        younger_nodes = secondary_siblings - older_nodes

        return older_nodes.concat([primary_node], primary_siblings, younger_nodes)
    end

    # Post-condition: all primary nodes are removed from @nodes
    def get_primary_nodes(parents)
        if @nodes.length == parents.length && @num_groups.zero?
            @nodes = []
            return parents
        end

        primary_nodes = []
        parents.each do |parent|
            node = get_primary_node(parent)
            primary_nodes.push(node) if !node.nil?
        end

        return primary_nodes.uniq
    end

    def get_primary_node(parent)
        index = @nodes.find_index { |node| Node.ids(node).include?(parent.id) }
        if !index.nil?
            node = @nodes[index]
            @nodes.delete_at(index)
            return node
        end

        return nil
    end

    def nodes_to_group
        nodes_to_group = []
        @nodes.each do |node|
            Node.persons(node).each do |person|
                nodes_to_group.concat(person.families.map(&:id)) if person.families.length > 1
            end
        end

        nodes_to_group.uniq!

        return @nodes.select { |node| nodes_to_group.include?(node.id) }
    end
end
