class EventList
    attr_reader :events

    def initialize
        @events = []
    end

    def push(event)
        @events.push(event)
    end

    def insert(events)
        @events.concat(events)
    end

    def concat(event_list)
        @events.concat(event_list.events)
    end

    def sort
        @events.sort! { |a, b| a.date.to_s <=> b.date.to_s }
        return self
    end
end
