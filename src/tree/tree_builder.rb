require_relative 'node'
require_relative 'tree'

class TreeBuilder
    def initialize
        @nodes = []
        @generations = {}
    end

    def make(ged)
        # Creates the nodes of a family tree. Nodes can be couples or individual
        # people if unmarried
        create_nodes(ged)

        # Creates generations and add nodes to their corresponding generation.
        create_generations

        # Add placeholder entities for unknown ancestors
        add_placeholders

        tree = Tree.new(@generations)
        return tree
    end

private

    def create_nodes(ged)
        ged.persons.each_value do |person|
            next if person.private?

            nodes = NodesFactory.make(person)
            nodes.each do |node|
                @nodes.push(node) if @nodes.none? { |n| n.id == node.id }
            end
        end
    end

    def create_generations
        create_generations_from_node(@nodes[0])

        keys = @generations.keys.sort.reverse
        @generations = keys.map { |key| @generations[key] }
    end

    def create_generations_from_node(node, visited = [], generation_number = 0)
        return if visited.include?(node) || node.nil?

        add_node_to_generation(node, visited, generation_number)

        children = find_children_nodes(node.children)
        add_nodes_to_generation(children, visited, generation_number + 1)

        parents = find_parent_nodes(node.parents)
        add_nodes_to_generation(parents, visited, generation_number - 1)
    end

    def add_node_to_generation(node, visited, generation_number = 0)
        @generations[generation_number] = Generation.new if !@generations.key?(generation_number)
        @generations[generation_number].add(node)

        visited.push(node)
    end

    def add_nodes_to_generation(nodes, visited, generation_number)
        nodes.each do |node|
            create_generations_from_node(node, visited, generation_number)
        end
    end

    def find_children_nodes(children)
        ids = children.map(&:id)
        ids.concat(family_ids(children))

        return @nodes.select { |node| ids.include?(node.id) }
    end

    def find_parent_nodes(parents)
        ids = parents.map(&:id)
        return @nodes.select { |node| ids.include?(node.id) }
    end

    def family_ids(persons)
        ids = []
        persons.each do |person|
            person.families.each do |family|
                ids.push(family.id)
            end
        end
        return ids
    end

    def add_placeholders
        @generations.each_with_index do |current_generation, index|
            break if index == @generations.length - 1

            parent_generation = @generations[index + 1]
            parent_generation.add_families(current_generation.parents)
        end
    end
end
