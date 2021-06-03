class Encoder
    def self.encode_url(value)
        return value.gsub(' ', '%20')
    end

    def self.encode_html(value)
        return value.gsub(' ', '&nbsp;')
    end
end
