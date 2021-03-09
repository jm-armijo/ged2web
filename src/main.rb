require_relative 'ged/parser'
require_relative 'web/builder'

class Main
    def self.execute
        parser = Parser.new
        ged = parser.parse

        builder = Builder.new
        builder.build(ged)
    end
end
