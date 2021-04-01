require_relative 'ged/parser'
require_relative 'web/builder'

class Main
    def self.execute(gedcom_path)
        ARGV.each do|a|
            puts "Argument: #{a}"
        end

        parser = Parser.new(gedcom_path)
        ged = parser.parse

        builder = Builder.new(ged)
        builder.build
    end
end
