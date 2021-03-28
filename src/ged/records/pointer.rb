class Pointer< RecordDecorator
    def method_missing(name, *args, &block)
        @reference.public_send(name, *args, &block)
    end
end
