require_relative 'file_manager'

class Builder
    def initialize(ged)
        @ged = ged
        @file_manager = FileManager.instance

        @page_dir = {
            person: 'ind',
            source: 'src'
        }
    end

    def build
        build_pages('INDI')
        build_pages('SOUR')
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

private

    def build_pages(tag)
        instances = @ged.records.filter { |_k, v| v.tag == tag }

        instances.each_value do |instance|
            build_page(instance)
        end
    end

    def build_page(instance)
        template_name = instance.class.name.downcase
        template = @file_manager.open_template("#{template_name}.html")
        page = template.result(binding)

        directory = @page_dir[template_name.to_sym]
        file_name = "#{instance.short_id}.html"
        @file_manager.save_page(page, directory, file_name)
    end
end
