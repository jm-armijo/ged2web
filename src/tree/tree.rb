require_relative './generation'

class Tree
    attr_reader :generations

    def initialize(generations)
        @generations = generations
    end
end
