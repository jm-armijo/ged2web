require_relative 'tree_node'

class NodeBuilder
    def create_node(person)
        if person.families.empty?
            return create_person_node(person)
        else
            return create_families_node(person)
        end
    end

private

    def create_person_node(person)
        node = TreeNode.new
        node.add(person)
        return node
    end

    def create_families_node(person)
        node = TreeNode.new
        families = person.families

        loop do
            num_nodes = node.length
            node.add_from_list(families)
            break if num_nodes == node.length

            spouses = families.map(&:spouses).flatten
            families = spouses.map(&:families).flatten
        end

        return node
    end
end
