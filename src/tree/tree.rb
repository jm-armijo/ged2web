require_relative './generation'

class Tree
    def initialize
        @generations = {}
        @keys = []
    end

    def add_group_to_generation(generation_number, group)
        generation = get_or_create_generation(generation_number)
        generation.add(group)
    end

    def generations
        return @keys.map { |key| @generations[key] }
    end

private

    def get_or_create_generation(generation_number)
        if !@generations.key?(generation_number)
            @generations[generation_number] = Generation.new
            @keys = @generations.keys.sort.reverse
        end
        return @generations[generation_number]
    end
end
