require_relative 'ged/ged'
require_relative 'tree/tree_builder'
require_relative 'list/list_builder'
require_relative 'web/builder'

class Main
    def self.execute(path)
        ged = Parser.new.parse(path)
        tree = TreeBuilder.new.make(ged)
        list = ListBuilder.new.make(ged)

        builder = WebBuilder.new
        builder.build_pages(ged.persons)
        builder.build_pages(ged.sources)
        # builder.build_section(tree)
        # builder.build_section(list)
    end
end
