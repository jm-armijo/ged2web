require_relative '../record_decorator'
require_relative '../event_list'
require_relative 'nil_event'

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
        @first_name ||= find('NAME').first_name
        return @first_name
    end

    def last_name
        @last_name ||= find('NAME').last_name
        return @last_name
    end

    def sosa
        @sosa ||= find('_SOSA')
        return @sosa
    end

    def birth
        @birth ||= find('BIRT') || NilEvent.new
        return @birth
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

    def avatar
        return multimedia&.first || nil
    end

private

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
