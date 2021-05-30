require_relative 'ged/ged'
require_relative 'tree/tree_builder'
require_relative 'list/list_builder'
require_relative 'web/builder'

class Main
    def self.execute(path)
        parser = Parser.new
        ged = parser.parse(path)

        tree_builder = TreeBuilder.new
        tree = tree_builder.make(ged)

        list_builder = ListBuilder.new
        list = list_builder.make(ged)

        builder = Builder.new(ged, tree, list)
        builder.build
    end
end
