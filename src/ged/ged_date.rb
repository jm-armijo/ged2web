require 'date'

class GedDate
    attr_reader :prefix
    attr_reader :day
    attr_reader :month
    attr_reader :year

    def initialize(date)
        @weekday = ''
        @day = ''
        @month = ''
        @year = ''

        if date.nil? || date.value.nil?
            @prefix = nil
            @date = nil
        else
            parse_date(date)
        end
    end

    # 1 if self>other; 0 if self==other; -1 if self<other
    def <=>(other)
        return 1 if other.nil? || other.date.nil?
        return -1 if @date.nil?

        date1 = @date.instance_of?(DateTime) ? @date.to_s : @date
        date2 = other.date.instance_of?(DateTime) ? other.date.to_s : other.date
        date1 <=> date2
    end

    def weekday
        map = {
            0  => 'Sunday',
            1  => 'Monday',
            2  => 'Tuesday',
            3  => 'Wednesday',
            4  => 'Thursday',
            5  => 'Friday',
            6  => 'Saturday',
            '' => ''
        }

        return map[@weekday]
    end

    def empty?
        return @date.nil?
    end

    def to_s
        return "#{@date} #{@prefix}"
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
                @weekday = @date.wday
                @day = @date.day
                @month = @date.strftime("%B")
                @year = @date.year
            rescue StandardError
                @date = match[2]
                @year = @date
            end
        end
    end
end
