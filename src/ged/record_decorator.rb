require_relative 'record'

class RecordDecorator < Record
    def id
        return @line.id
    end

    def tag
        return @line.tag
    end

    def value
        return @value || @line.value
    end

    def short_id
        return id.sub(/^@\w0*(\d+)@/, '\1').to_i
    end

    def references
        return find_all('SOUR')
    end

    def notes
        return find_all('NOTE')
    end

    def multimedia
        return find_all('OBJE')
    end

    def to_s
        return value || ''
    end

    def to_str
        return to_s
    end

private

    def find_events(event_tags)
        events = EventList.new

        event_tags.each do |tag|
            events.insert(find_all(tag))
        end
        return events
    end
end
