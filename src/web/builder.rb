require 'erb'
require 'fileutils'

class Builder
    def initialize
        @base_dir = Dir.pwd
    end

    def build(ged)
        persons = ged.records.filter { |_k, v| v.type == 'INDI' }

        persons.each_value do |person|
            build_person_page(person)
        end
    end

private

    def build_person_page(person)
        template = open_template('person.html')
        page = template.result(binding)

        directory = 'ind'
        file_name = "#{person.id.tr('@', '')}.html"
        save_page(page, directory, file_name)
    end

    def open_template(file_name)
        Dir.chdir('./src/web/templates')
        template = ERB.new(File.read(file_name))
        Dir.chdir(@base_dir)

        return template
    end

    def save_page(content, directory, file_name)
        directory = "./out/#{directory}/"
        FileUtils.mkdir_p(directory) if !File.directory?(directory)

        Dir.chdir(directory)
        File.write(file_name, content)
        Dir.chdir(@base_dir)
    end
end
