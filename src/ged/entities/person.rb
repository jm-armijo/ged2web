require_relative '../entity'

class Person < Entity
    def initialize(record)
        super(record)

        @life_event_types = [
            'ADOP',
            'BAPM',
            'BAPL',
            'BARM',
            'BASM',
            'BLES',
            'CHR',
            'CONF',
            'CHRA',
            'EMIG',
            'FCOM',
            'GRAD',
            'IMMI',
            'NATU',
            'ORDN',
            'RETI',
            'WILL',
            'EVEN',
            'CENS'
        ]

        @post_mortem_event_types = [
            'BURI',
            'CREM',
            'PROB'
        ]
    end

    def first_name
        @first_name ||= extract_first_name
        return @first_name
    end

    def last_name
        @last_name ||= extract_last_name
        return @last_name
    end

    def sosa
        @sosa ||= find('_SOSA')
        return @sosa
    end

    def gender
        @gender ||= find('SEX')
        return @gender
    end

    def events
        @events ||= extract_events
        return @events
    end

    def sources
        @sources ||= @record.deep_find_all('SOUR')
        return @sources
    end

private

    def extract_first_name
        name = find('NAME')
        return name.find('GIVN') || split_name(name.value).first
    end

    def extract_last_name
        name = find('NAME')
        return name.find('SURN') || split_name(name.value).last
    end

    def split_name(name)
        if (match = name&.match(/^(.*?)\/(.*?)\/?\s*$/i))
            return match.captures.map(&:strip!)
        end

        if (match = name&.match(/^(.*?)\/\s*$/i))
            return '', match.captures.strip!
        end

        return '', ''
    end

    def extract_events
        events = []

        # Birth is always the first event (should have only one, supporting many)
        events.concat(find_all('BIRT'))

        # Get all events while the person was/is alive
        events.concat(life_events)

        # Death is the event after all the live events
        events.concat(find_all('DEAT'))

        # Some events occur after the person died
        events.concat(post_mortem_event)
    end

    def life_events
        return find_events(@life_event_types)
    end

    def post_mortem_event
        return find_events(@post_mortem_event_types)
    end

    def find_events(event_types)
        events = []
        event_types.each do |type|
            events.concat(find_all(type))
        end
        return events
    end
end
