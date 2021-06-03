require_relative './page'

class BasePageBuilder
    def initialize
        @file_manager = FileManager.instance
    end

    def build(instance, language, file_name)
        template = @file_manager.open_template("#{@template_name}.html")

        page = Page.new(instance, language, @styles)
        bound_template = template.result(binding)

        @file_manager.save_page(bound_template, @directory_name, file_name)
    end
end
