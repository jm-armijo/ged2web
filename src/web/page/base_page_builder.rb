require_relative './page'

class BasePageBuilder
    def initialize
        @file_manager = FileManager.instance
    end

    def build(instance, languages, file_name)
        base_page = create_base_page(instance, languages, file_name)

        languages.each do |language|
            create_page_in_language(base_page, language)
        end
    end

private

    def create_base_page(instance, languages, file_name)
        base_page = Page.new
        base_page.url = "#{@directory_name}/#{file_name}"
        base_page.data = instance
        base_page.languages = languages
        base_page.styles = @styles
        return base_page
    end

    def create_page_in_language(base_page, language)
        page = get_page_in_language(base_page, language)
        template = get_bound_template(page)
        path = get_language_path(page, language)

        @file_manager.save_page(template, path)
    end

    def get_page_in_language(base_page, language)
        page = base_page.clone
        page.language = language
        return page
    end

    def get_bound_template(page)
        template = @file_manager.open_template("#{@template_name}.html")
        return template.result(binding)
    end

    def get_language_path(page, language)
        return "#{language}/#{page.url}"
    end
end
