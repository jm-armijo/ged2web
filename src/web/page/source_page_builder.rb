require_relative './base_page_builder'

class SourcePageBuilder < BasePageBuilder
    def initialize
        super
        @template_name  = 'source'
        @styles = ['source']
    end

    def build(instance, languages)
        @directory_name = "source/#{instance.short_id}"
        file_name = 'index.html'
        super(instance, languages, file_name)
    end
end
