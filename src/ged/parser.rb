require_relative 'ged'
require_relative 'line'

class Parser
    def initialize
        @ged = Ged.new
    end

    def parse
        File.foreach('/home/jarmijo/code/personal/family/tree/ArbolGenealogico.ged') do |raw_line|
            line = Line.new(raw_line)
            @ged.add(line)
        end

        @ged.resolve_pointers

        return @ged
    end
end
