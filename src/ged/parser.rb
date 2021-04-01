require_relative 'ged'
require_relative 'line'

class Parser
    def initialize(gedcom_path)
        @ged = Ged.new
        @path = gedcom_path
    end

    def parse
        File.foreach(@path) do |raw_line|
            line = Line.new(raw_line)
            @ged.add(line)
        end

        @ged.resolve_pointers

        return @ged
    end
end
