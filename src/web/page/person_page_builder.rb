require_relative './base_page_builder'

class PersonPageBuilder < BasePageBuilder
    def initialize
        super
        @template_name  = 'person'
        @directory_name = 'ind'
        @styles = ['person']
    end

    def build(instance, language)
        file_name = "#{instance.short_id}.html"
        super(instance, language, file_name)
    end
end
