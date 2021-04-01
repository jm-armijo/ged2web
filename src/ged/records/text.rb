require_relative '../record_decorator'

class Text < RecordDecorator
    def value
        text = [@line.value]
        @records.each do |record|
            text.push(record.value) if record.tag == 'CONT'
            text[-1] += record.value if record.tag == 'CONC'
        end

        return text
    end
end
