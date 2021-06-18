require_relative './base_page_builder'

class PersonPageBuilder < BasePageBuilder
    def initialize
        super
        @template_name  = 'person'
        @styles = ['person']
    end

    def build(instance, languages)
        @directory_name = "person/#{instance.short_id}"
        file_name = 'index.html'
        super(instance, languages, file_name)
    end
end
