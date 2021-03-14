require_relative '../entity'

class Note < Entity
    def value
        @parts ||= parts
        return @parts
    end

private

    def parts
        parts = []
        parts.push(@record.value) if !@record.value.nil?

        parts.concat(next_lines)
        return parts
    end

    def next_lines
        return find_all('CONT').map(&:value)
    end
end
