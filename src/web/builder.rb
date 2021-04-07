require_relative 'object_importer'
require_relative 'page_builder'

class Builder
    def initialize(ged, tree)
        @ged  = ged
        @tree = tree
    end

    def build
        build_tree
        build_pages(@ged.persons)
        build_pages(@ged.sources)
        import_files
    end

private

    def build_tree
        puts 'this is a tree'
    end

    def build_pages(instances)
        builder = PageBuilder.new
        instances.each_value do |instance|
            builder.build_page(instance)
        end
    end

    def import_files
        importer = ObjectImporter.new(@ged)
        importer.import
    end
end
