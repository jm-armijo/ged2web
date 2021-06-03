require_relative './base_page_builder'

class ListPageBuilder < BasePageBuilder
    def initialize
        super
        @template_name  = 'list'
        @directory_name = 'list'
        @styles = ['list']
    end

    def build(instance, language)
        file_name = 'index.html'
        super(instance, language, file_name)
    end
end
