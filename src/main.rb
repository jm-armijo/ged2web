require_relative 'ged/ged'
require_relative 'tree/tree_builder'
require_relative 'web/builder'
require_relative 'web/object_importer'

class Main
    def self.execute(path)
        parser = Parser.new
        ged = parser.parse(path)

        tree_builder = TreeBuilder.new
        tree = tree_builder.make(ged)

        builder = Builder.new(ged, tree)
        builder.build

        importer = ObjectImporter.new(ged)
        importer.import
    end
end
