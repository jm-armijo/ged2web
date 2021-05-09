require_relative 'tree'
require_relative 'node_builder'

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

        arrange_generations

        tree = Tree.new(@generations)
        return tree
    end

private

    def create_nodes(ged)
        node_builder = NodeBuilder.new

        persons = ged.persons.clone
        while !persons.empty?
            person = persons.first[1]
            node = node_builder.create_node(person)
            persons.delete_if { |key, _v| node.persons.map(&:id).include?(key) }

            @nodes.push(node)
        end
    end

    def create_generations
        create_generations_from_node(@nodes[0])

        keys = @generations.keys.sort.reverse
        @generations = keys.map { |key| @generations[key] }
    end

    def add_placeholders
        @generations.each_with_index do |current_generation, index|
            break if index == @generations.length - 1

            parent_generation = @generations[index + 1]
            parent_generation.add_families(current_generation.parents)
        end
    end

    def arrange_generations
        parents = []
        @generations.each_with_index do |generation, index|
            puts "Processing generation #{index + 1}"
            generation.group_nodes

            generation.sort(parents)
            parents = generation.parents

            # This step needs to be done last
            generation.create_placehodlers
        end
    end

    def create_generations_from_node(node, visited = [], generation_number = 0)
        return if visited.include?(node) || node.nil?

        add_node_to_generation(node, visited, generation_number)

        children = find_children_of_node(node)
        add_nodes_to_generation(children, visited, generation_number + 1)

        parents = find_parents_of_node(node)
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

    def find_children_of_node(parent_node)
        ids = parent_node.children.map(&:id)
        return @nodes.select { |node| node.any_person?(ids) }
    end

    def find_parents_of_node(child_node)
        ids = child_node.parents.map(&:id)
        return @nodes.select { |node| node.any_family?(ids) }
    end
end
