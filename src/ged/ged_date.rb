require 'date'

class GedDate
    attr_reader :prefix

    def initialize(date)
        if date.nil? || date.value.nil?
            @prefix = ''
            @date = nil
        else
            parse_date(date)
        end
    end

    # 1 if self>other; 0 if self==other; -1 if self<other
    def <=>(other)
        return 1 if other.date.nil?
        return -1 if @date.nil?

        date <=> other.date
    end

    def natural
        @date.strftime('%-d %B %Y')
    rescue StandardError
        return @date
    end

    def empty?
        return @date.nil?
    end

    def to_s
        return value || ''
    end

    def to_str
        return to_s
    end

protected

    def date
        return @date
    end

    def parse_date(date)
        if (match = date.value.match(/^(?:([[:alpha:]]+) )?(.*)$/i))
            @prefix = match[1]

            begin
                @date = DateTime.parse(match[2])
            rescue StandardError
                @date = match[2]
            end
        end
    end
end
