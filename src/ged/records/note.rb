require_relative '../record_decorator'

class Note < RecordDecorator
    def parts
        @parts ||= join_parts
        return @parts
    end

private

    def join_parts
        parts = []
        parts.push(@reference.value) if !@reference.value.nil?

        parts.concat(next_lines)
        return parts
    end

    def next_lines
        return @reference.find_all('CONT').map(&:value)
    end
end
