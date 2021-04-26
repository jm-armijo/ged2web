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

        arrange_generations

        tree = Tree.new(@generations)
        return tree
    end

private

    def create_nodes(ged)
        nodes = []
        ged.persons.each_value do |person|
            next if person.private?

            nodes += person.families? ? person.families : [person]
        end

        @nodes = nodes.uniq(&:id)
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
            puts "Processing generation #{index}"
            generation.group_nodes

            generation.sort(parents)
            parents = generation.parents
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
        children = parent_node.respond_to?('children') ? parent_node.children : []
        ids = children.map(&:id)
        ids.concat(family_ids(children))

        return @nodes.select { |node| ids.include?(node.id) }
    end

    def find_parents_of_node(child_node)
        ids = child_node.parents.map(&:id)
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
end
