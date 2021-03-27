class Line
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

    def level
        return @first
    end

    def id
        if level.zero?
            id = @third.nil? ? 0 : @second
        else
            id = @third&.match(/^@.*@$/) ? @third : nil
        end

        return id
    end

    def tag
        if level.zero?
            tag = @third.nil? ? @second : @third
        else
            tag = @second
        end

        return tag
    end

    def value
        if level.zero?
            value = @third.nil? ? nil : @fourth
        else
            value = @third&.match(/^@.*@$/) ? nil : @third
        end

        return value
    end
end
