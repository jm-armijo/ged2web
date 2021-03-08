require_relative 'data/parser'

class Main
    def self.execute
        parser = Parser.new
        ged = parser.parse
        indis = ged.records.filter { |_k, v| v.type == 'INDI' }
        puts indis.keys.length

        # Generate tree
    end
end
