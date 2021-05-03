require_relative 'file_manager'

class ObjectImporter
    def initialize(ged)
        @ged = ged
    end

    def import
        import_objects
        import_dependencies
    end

private

    def import_objects
        directory = './out/obj/'
        FileUtils.mkdir_p(directory)

        @ged.objects.each_value do |instance|
            new_path = "#{directory}/#{instance.short_id}.#{instance.format}"
            FileUtils.cp(instance.file, new_path)
        end
    end

    def import_dependencies
        directory = './out/css/'
        FileUtils.mkdir_p(directory)

        FileUtils.cp('css/person.css', './out/css/')
        FileUtils.cp('css/source.css', './out/css/')
        FileUtils.cp('css/base.css',   './out/css/')
        FileUtils.cp('css/tree.css',   './out/css/')
    end
end
