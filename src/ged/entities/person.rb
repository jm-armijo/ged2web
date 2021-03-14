require_relative '../entity'

class Person < Entity
    def first_name
        @first_name ||= get_first_name
        return @first_name
    end

    def last_name
        @last_name ||= get_last_name
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
        @events ||= get_events
        return @events
    end

private

    def get_first_name
        name = find('NAME')
        return name.find('GIVN') || split_name(name.value).first
    end

    def get_last_name
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

    def get_events
        events = []
        events.concat(find_all('BIRT'))

        life_events = []
        life_events.concat(find_all('ADOP'))
        life_events.concat(find_all('BAPM'))
        life_events.concat(find_all('BAPL'))
        life_events.concat(find_all('BARM'))
        life_events.concat(find_all('BASM'))
        life_events.concat(find_all('BLES'))
        life_events.concat(find_all('CHR'))
        life_events.concat(find_all('CONF'))
        life_events.concat(find_all('CHRA'))
        life_events.concat(find_all('EMIG'))
        life_events.concat(find_all('FCOM'))
        life_events.concat(find_all('GRAD'))
        life_events.concat(find_all('IMMI'))
        life_events.concat(find_all('NATU'))
        life_events.concat(find_all('ORDN'))
        life_events.concat(find_all('RETI'))
        life_events.concat(find_all('WILL'))
        life_events.concat(find_all('EVEN'))
        life_events.concat(find_all('CENS'))
        events.concat(life_events)

        events.concat(find_all('DEAT'))

        death_events = []
        death_events.concat(find_all('BURI'))
        death_events.concat(find_all('CREM'))
        death_events.concat(find_all('PROB'))
        events.concat(death_events)
    end
end
