class Node
    def self.persons(node)
        return node.respond_to?('persons') ? node.persons : [node]
    end

    def self.ids(node)
        return node.id.is_a?(Array) ? node.id : [node.id]
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

    def self.group_nodes(nodes)
        grouped_nodes = []
        while nodes.length.positive?
            group = Node.group_related_nodes(nodes)
            grouped_nodes.push(group)
        end

        return grouped_nodes
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

    def self.unions(node)
        case node.type
        when 'Person'
            return [node]
        when 'Family'
            return [node.husband, node, node.wife]
        end
        return group_unions(node)
    end

    def self.group_unions(group)
        families = group.nodes.clone
        unions = [families[0].husband]

        while families.length.positive?
            push_families_into_unions(unions, families)
            unshift_families_into_unions(unions, families)
        end

        return unions
    end

    def self.push_families_into_unions(unions, families)
        last_person = unions.last
        family = find_and_pop_family(families, last_person)
        return if family.nil?

        unions.push(family)
        unions.push(family.other_spouse(last_person))
    end

    def self.unshift_families_into_unions(unions, families)
        first_person = unions.first
        family = find_and_pop_family(families, first_person)
        return if family.nil?

        unions.unshift(family)
        unions.unshift(family.other_spouse(first_person))
    end

    def self.find_and_pop_family(families, spouse)
        index = families.find_index { |family| family.spouse?(spouse) }
        return nil if index.nil?

        family = families[index]
        families.delete_at(index)
        return family
    end

    def self.find_first_null_family(nodes, start_index)
        (start_index..nodes.length - 1).each do |index|
            return index if nodes[index].instance_of?(NullFamily)
        end
        return nil
    end

    def self.find_first_non_null_family(nodes, start_index)
        (start_index..nodes.length - 1).each do |index|
            return index if !nodes[index].instance_of?(NullFamily)
        end
        return nil
    end

    def self.find_nodes_with_siblings(nodes_to_search, siblings)
        return siblings.map do |sibling|
            nodes_to_search.select { |node| node.person?(sibling) }
        end.flatten.uniq
    end
end
