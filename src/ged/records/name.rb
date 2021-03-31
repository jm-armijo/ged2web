class Name < RecordDecorator
    def first_name
        first_name = find('GIVN')&.value || split_name(value).first || ''
        return first_name.tr(',', '')
    end

    def last_name
        last_name = find('SURN')&.value || split_name(value).last || ''
        return last_name.tr(',', '')
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
