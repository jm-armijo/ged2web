require_relative 'file_manager'

class Builder
    def initialize
        @file_manager = FileManager.instance
    end

    def build(ged)
        persons = ged.records.filter { |_k, v| v.tag == 'INDI' }

        persons.each_value do |person|
            build_person_page(person)
        end
    end

    def build_person_page(person)
        template = @file_manager.open_template('person.html')
        page = template.result(binding)

        directory = 'ind'
        file_name = "#{person.id.tr('@', '')}.html"
        @file_manager.save_page(page, directory, file_name)
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
end
