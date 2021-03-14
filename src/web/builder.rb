require_relative 'file_manager'
require_relative 'section'

class Builder
    def initialize
        @file_manager = FileManager.instance
    end

    def build(ged)
        persons = ged.entities.filter { |_k, v| v.type == 'INDI' }

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
end
