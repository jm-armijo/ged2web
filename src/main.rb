require_relative 'ged/ged'
require_relative 'tree/tree_builder'
require_relative 'list/list_builder'
require_relative 'web/builder'

class Main
    def self.execute(path)
        language = 'en'
        builder = WebBuilder.new

        ged = Parser.new.parse(path)
        builder.build_pages(ged.persons, language)
        builder.build_pages(ged.sources, language)

        tree = TreeBuilder.new.make(ged)
        builder.build_page(tree, language)

        list = ListBuilder.new.make(ged)
        builder.build_page(list, language)

        builder.import_assets(ged.objects)
    end
end
