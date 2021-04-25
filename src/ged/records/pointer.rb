class Pointer < RecordDecorator
    def method_missing(name, *args, &block)
        @reference.public_send(name, *args, &block)
    end

    def respond_to?(method_name, include_all=false)
        return @reference.respond_to?(method_name, include_all)
    end
end
