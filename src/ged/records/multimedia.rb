require_relative '../record_decorator'

class Multimedia < RecordDecorator
    def url
        return "obj/#{short_id}.#{format}"
    end

    def file
        return find('FILE') || ''
    end

    def format
        return find('FILE')&.find('FORM') || ''
    end

    def title
        return find('FILE')&.find('TITL') || ''
    end
end
