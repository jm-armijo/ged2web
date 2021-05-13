require_relative 'tree_node'

class NodeBuilder
    def create_node(node)
        if node.type == 'Family'
            tree_node = create_family_node(node)
        elsif node.families.empty?
            tree_node = create_person_node(node)
        else
            tree_node = create_families_node(node)
        end

        return tree_node
    end

private

    def create_person_node(person)
        node = TreeNode.new
        node.add(person)
        return node
    end

    def create_family_node(family)
        tree_node = TreeNode.new
        tree_node.add_from_list([family])
        return tree_node
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
