require_relative 'page_builder'

class Builder
    def initialize(ged, tree)
        @ged  = ged
        @tree = tree
    end

    def build
        build_tree
        build_pages('INDI')
        build_pages('SOUR')
    end

private

    def build_tree
        puts 'this is a tree'
    end

    def build_pages(tag)
        instances = @ged.records.filter { |_k, v| v.tag == tag }

        builder = PageBuilder.new
        instances.each_value do |instance|
            builder.build_page(instance)
        end
    end
end
