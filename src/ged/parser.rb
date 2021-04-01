require_relative 'ged'
require_relative 'line'

class Parser
    def parse(ged)
        File.foreach(ged.path) do |raw_line|
            line = Line.new(raw_line)
            ged.add(line)
        end

        ged.resolve_pointers
        ged.update_paths
    end
end
