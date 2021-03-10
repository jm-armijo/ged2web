require 'erb'
require 'fileutils'
require 'singleton'

class FileManager
    include Singleton

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

private

    private_class_method :new

    def initialize
        @base_dir = Dir.pwd
    end
end
