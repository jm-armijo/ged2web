require_relative './object_importer'
require_relative './page/page_builder'

class WebBuilder
    def build(ged, languages)
        build_persons_pages(ged, languages)
        build_sources_pages(ged, languages)

        build_tree_page(ged, languages)
        build_list_page(ged, languages)
    end

    def import_files(ged)
        import_objects(ged)
        import_assets
    end

private

    def build_persons_pages(ged, languages)
        persons = filter_persons(ged.persons)
        build_pages(persons, languages)
    end

    def build_sources_pages(ged, languages)
        sources = filter_sources(ged.sources)
        build_pages(sources, languages)
    end

    def build_tree_page(ged, languages)
        tree = TreeBuilder.new.make(ged)
        build_page(tree, languages)
    end

    def build_list_page(ged, languages)
        list = ListBuilder.new.make(ged)
        build_page(list, languages)
    end

    def filter_persons(persons)
        return persons.reject { |_k, p| p.private? }
    end

    def filter_sources(sources)
        return sources.select { |_k, s| s.persons.none?(&:alive?) }
    end

    def filter_objects(objects)
        return objects.select { |_k, o| o.sources.all? { |s| s.persons.none?(&:alive?) } }
    end

    def build_pages(instances, languages)
        instances.each_value do |instance|
            build_page(instance, languages)
        end
    end

    def build_page(instance, languages)
        PageBuilder.build(instance, languages)
    end

    def import_objects(ged)
        importer = ObjectImporter.new
        objects = filter_objects(ged.objects)
        importer.import_ged_objects(objects)
    end

    def import_assets
        importer = ObjectImporter.new
        importer.import_common_assets
    end
end
