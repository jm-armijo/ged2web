require_relative '../record_decorator'

class Note < RecordDecorator
    def parts
        @parts ||= join_parts
        return @parts
    end

private

    def join_parts
        parts = []
        parts.push(value) if !value.nil?

        parts.concat(next_lines)
        return parts
    end

    def next_lines
        return find_all('CONT').map(&:value)
    end
end
