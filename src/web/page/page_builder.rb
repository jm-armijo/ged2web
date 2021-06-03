require_relative './person_page_builder'
require_relative './source_page_builder'
require_relative './tree_page_builder'
require_relative './list_page_builder'

class PageBuilder
    def self.build(instance, language)
        builder(instance).build(instance, language)
    end

    def self.builder(instance)
        if instance.respond_to?('type') && instance.type == 'Person'
            builder = PersonPageBuilder.new
        elsif instance.class.name == 'Source'
            builder = SourcePageBuilder.new
        elsif instance.class.name == 'Tree'
            builder = TreePageBuilder.new
        elsif instance.class.name == 'Array'
            builder = ListPageBuilder.new
        else
            raise "Can't get builder for variable of type '#{instance.class.name}'"
        end

        return builder
    end
end
