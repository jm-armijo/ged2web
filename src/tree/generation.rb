class Generation
    attr_reader :groups

    def initialize
        @groups = []
    end

    def add(group)
        @groups.push(group)
    end
end
