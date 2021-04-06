require_relative 'ged/parser'
require_relative 'tree/tree'
require_relative 'web/builder'
require_relative 'web/object_importer'

class Main
    def self.execute(gedcom_path)
        path = File.expand_path(gedcom_path)
        ged = Ged.new(path)

        parser = Parser.new
        parser.parse(ged)

        builder = Builder.new(ged)
        builder.build

        importer = ObjectImporter.new(ged)
        importer.import

        tree = Tree.new(ged)
        tree.groups
    end
end
