require_relative './page'

class BasePageBuilder
    def initialize
        @file_manager = FileManager.instance
    end

    def build(instance, languages, file_name)
        template = @file_manager.open_template("#{@template_name}.html")

        languages.each do |language|
            page = Page.new(instance, language, @styles)
            bound_template = template.result(binding)
            directory = "#{language}/#{@directory_name}"
            @file_manager.save_page(bound_template, directory, file_name)
        end
    end
end
