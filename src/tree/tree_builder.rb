require_relative 'tree'
require_relative 'node_builder'

class TreeBuilder
    def initialize
        @node_builder = NodeBuilder.new

        @nodes = []
        @generations = {}
        @nodes_map = {}
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
        persons = ged.persons.clone
        while !persons.empty?
            person = persons.first[1]
            node = @node_builder.create_node(person)
            update_map(node)
            persons.delete_if { |key, _v| node.persons.map(&:id).include?(key) }

            @nodes.push(node)
        end
    end

    def update_map(node)
        node.persons.each do |person|
            @nodes_map[person.id] = node
        end

        node.families.each do |family|
            @nodes_map[family.id] = node
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

            current_generation.create_dummy_parents
            parents = get_generation_parents(current_generation)

            parent_generation = @generations[index + 1]
            parents.each do |node|
                parent_generation.add(node) if node.dummy?
            end
        end
    end

    def get_or_create_node(node_parents)
        return @nodes_map[node_parents.id] if @nodes_map.key?(node_parents.id)

        node = @node_builder.create_node(node_parents)
        update_map(node)
        return node
    end

    def get_generation_parents(generation)
        parents = []
        generation.parents.each do |node_parents|
            parents.push(get_or_create_node(node_parents))
        end
        return parents.uniq
    end

    def arrange_generations
        sorted_parents = []
        tree_node_parents = []
        @generations.each_with_index do |generation, index|
            puts "Processing generation #{index + 1}"

            generation.sort(tree_node_parents, sorted_parents)

            sorted_parents = generation.parents
            tree_node_parents = get_generation_parents(generation)

            # This step needs to be done last, one all dummy families of the
            # generation have been created and can be replaced by a placeholder.
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
