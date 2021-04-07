require_relative 'ged/ged'
require_relative 'tree/tree_builder'
require_relative 'web/builder'

class Main
    def self.execute(path)
        parser = Parser.new
        ged = parser.parse(path)

        tree_builder = TreeBuilder.new
        tree = tree_builder.make(ged)

        builder = Builder.new(ged, tree)
        builder.build
    end
end
