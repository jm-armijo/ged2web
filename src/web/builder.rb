require_relative 'object_importer'
# require_relative 'page_builder'
require_relative './page/page_builder'

class WebBuilder
    def build_pages(instances)
        instances.each_value do |instance|
            PageBuilder.build(instance)
        end
    end

    # private
    #
    #    def build_tree
    #        @builder.build_page(@tree, 'index.html')
    #    end
    #
    #    def build_list
    #        @builder.build_page(@list, 'index.html')
    #    end
    #
    #    def import_files
    #        importer = ObjectImporter.new(@ged)
    #        importer.import
    #    end
end
