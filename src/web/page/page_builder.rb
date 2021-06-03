require_relative './person_page_builder'
require_relative './source_page_builder'
require_relative './tree_page_builder'
require_relative './list_page_builder'

class PageBuilder
    def self.build(instance, language)
        builder = get_builder(instance)
        builder.build(instance, language)
    end

    def self.get_builder(instance)
        map = {
            'Person' => PersonPageBuilder,
            'Source' => SourcePageBuilder,
            'Tree'   => TreePageBuilder,
            'Array'  => ListPageBuilder
        }

        type = instance_type(instance)
        return map[type].new if map.key?(type)

        raise "Can't get builder for variable of type '#{type}'"
    end

    def self.instance_type(instance)
        if instance.respond_to?('type')
            return instance.type
        else
            return instance.class.name
        end
    end
end
