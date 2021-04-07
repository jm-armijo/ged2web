require_relative 'file_manager'
require_relative 'translator'

class PageBuilder
    def initialize
        @file_manager = FileManager.instance
        @translator = Translator.new('en')
        @page_dir = {
            person: 'ind',
            source: 'src',
            tree:   '.'
        }
    end

    def build_common_section(section)
        template = @file_manager.open_template("#{section}.html")
        return template.result(binding)
    end

    def build_list(section, records)
        return '' if records.length.zero?

        template = @file_manager.open_template("#{section}.html")
        return template.result(binding)
    end

    def build_section(section, record)
        return '' if record.nil?

        template = @file_manager.open_template("#{section}.html")
        return template.result(binding)
    end

    def encode_url(value)
        encoded_value = value.gsub(' ', '%20')
        return encoded_value
    end

    def encode_html(value)
        encoded_value = value.gsub(' ', '&nbsp;')
        return encoded_value
    end

    def translate(tag)
        return @translator.translate(tag)
    end

    def build_page(instance, file_name = nil)
        file_name ||= "#{instance.short_id}.html"

        template_name = instance.class.name.downcase
        template = @file_manager.open_template("#{template_name}.html")
        page = template.result(binding)

        directory = @page_dir[template_name.to_sym]
        @file_manager.save_page(page, directory, file_name)
    end
end
