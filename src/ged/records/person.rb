class Person < Record
    def first_name
        @first_name ||= find_first_name
        return @first_name
    end

    def last_name
        @last_name ||= find_last_name
        return @last_name
    end

    def sosa
        @sosa ||= find('_SOSA')&.value || ''
    end

    def gender
        @gender ||= find('SEX')&.value || ''
        return @gender
    end

private

    def find_first_name
        name = find('NAME')
        return name.find('GIVN')&.value || split_name(name.value).first
    end

    def find_last_name
        name = find('NAME')
        return name.find('SURN')&.value || split_name(name.value).last
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
