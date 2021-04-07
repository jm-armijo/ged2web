class Tree
    attr_reader :generations

    def initialize
        @generations = {}
    end

    def add_group_to_generation(generation, group)
        @generations[generation] = [] if !@generations.key?(generation)
        @generations[generation].push(group)
    end
end
