require_relative 'object_importer'
require_relative 'page_builder'

class Builder
    def initialize(ged, tree, list)
        @ged  = ged
        @tree = tree
        @list = list
        @builder = PageBuilder.new
    end

    def build
        build_tree
        build_list
        build_pages(@ged.persons)
        build_pages(@ged.sources)
        import_files
    end

private

    def build_tree
        @builder.build_page(@tree, 'index.html')
    end

    def build_list
        @builder.build_page(@list, 'index.html')
    end

    def build_pages(instances)
        instances.each_value do |instance|
            @builder.build_page(instance)
        end
    end

    def import_files
        importer = ObjectImporter.new(@ged)
        importer.import
    end
end
