require_relative '../ged_date'

class Event < RecordDecorator
    def date
        @date ||= GedDate.new(find('DATE'))
        return @date
    end

    def place
        @place ||= find('PLAC')
        return @place
    end

    def empty?
        return date.empty? && (place.nil? || place.value.nil?) && notes.length == 0
    end
end
