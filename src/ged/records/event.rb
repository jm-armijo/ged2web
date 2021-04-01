class Event < RecordDecorator
    def date
        @date ||= find('DATE')
        return @date
    end

    def place
        @place ||= find('PLAC')
        return @place
    end
end