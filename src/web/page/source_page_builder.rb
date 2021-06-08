require_relative './base_page_builder'

class SourcePageBuilder < BasePageBuilder
    def initialize
        super
        @template_name  = 'source'
        @directory_name = 'source'
        @styles = []
    end

    def build(instance, languages)
        file_name = "#{instance.short_id}.html"
        super(instance, languages, file_name)
    end
end
