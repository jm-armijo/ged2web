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
end
