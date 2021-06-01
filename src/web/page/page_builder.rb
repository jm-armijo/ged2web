require_relative './person_page_builder'
require_relative './source_page_builder'

class PageBuilder
    def self.build(instance)
        case instance.type
        when 'Person'
            builder = PersonPageBuilder.new
        when 'Source'
            builder = SourcePageBuilder.new
        else
            raise "No clue where to get a builder for type '#{instance.type}'"
        end

        builder.build(instance)
    end
end
