require_relative './base_page_builder'

class TreePageBuilder < BasePageBuilder
    def initialize
        super
        @template_name  = 'tree'
        @directory_name = 'tree'
        @styles = ['tree']
    end

    def build(instance, languages)
        file_name = 'index.html'
        super(instance, languages, file_name)
    end
end
