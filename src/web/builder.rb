require_relative 'object_importer'
# require_relative 'page_builder'
require_relative './page/page_builder'

class WebBuilder
    def build_pages(instances, language)
        instances.each_value do |instance|
            build_page(instance, language)
        end
    end

    def build_page(instance, language)
        PageBuilder.build(instance, language)
    end

    def import_assets(objects)
        importer = ObjectImporter.new
        importer.import_ged_objects(objects)
        importer.import_common_assets
    end
end
