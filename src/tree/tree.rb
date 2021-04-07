class Tree
    attr_reader :generations

    def initialize
        @generations = {}
    end

    def add_group_to_generation(generation, group)
        @generations[generation] = [] if !@generations.key?(generation)
        @generations[generation].push(group)
    end

    def generations
        keys = @generations.keys.sort.reverse
        return keys.map { |key| @generations[key] }
    end
end
