require_relative '../record_decorator'
require_relative '../event_list'

class Person < RecordDecorator
    def initialize(line)
        super

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

    def parents
        @parents ||= find_all('FAMC')&.first || nil
        return @parents
    end

    def father
        return parents&.husband || nil
    end

    def mother
        return parents&.wife || nil
    end

    def events
        @events ||= extract_events
        return @events
    end

    def sources
        @sources ||= find_sources
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

    def families
        @families ||= find_all('FAMS')
        return @families
    end

    def extract_events
        events = EventList.new

        # Birth is always the first event (should have only one, supporting many)
        events.concat(find_events(['BIRT']))

        events.concat(life_events)

        # Death is the event after all the life events
        events.concat(find_events(['DEAT']))

        events.concat(post_mortem_events)
    end

    # Get all events while the person was/is alive,
    # including family events (such as marriage)
    def life_events
        events = find_events(@life_event_types)

        families.each do |family|
            events.concat(family.events)
        end

        return events.sort
    end

    # Some events occur after the person died
    def post_mortem_events
        events = find_events(@post_mortem_event_types)
        return events.sort
    end
end
