require_relative './base_page_builder'

class SourcePageBuilder < BasePageBuilder
    def initialize
        super
        @template_name  = 'source'
        @directory_name = 'src'
        @styles = []
    end

    def build(instance)
        file_name = "#{instance.short_id}.html"
        super(instance, file_name)
    end
end
