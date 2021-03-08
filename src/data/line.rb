class Line
    attr_reader :first
    attr_reader :second
    attr_reader :third
    attr_reader :fourth

    def initialize(line)
        if (match = line.match(/^(0) (@\S+@)(?: (\S+))(?: (.*))?$/i))
            @first, @second, @third, @fourth = match.captures
        elsif (match = line.match(/^(\d+) (\S+)(?: (.*))?$/i))
            @first, @second, @third = match.captures
        else
            raise "Cannot process line '#{line}'"
        end
        @first = @first.to_i
    end
end
