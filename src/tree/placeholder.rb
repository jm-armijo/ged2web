class Placeholder
    attr_reader :size

    def initialize(size)
        @size = size
    end

    def private?
        return false
    end
end
