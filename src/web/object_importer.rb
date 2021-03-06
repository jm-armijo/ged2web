require_relative 'file_manager'

class ObjectImporter
    def import_ged_objects(objects)
        directory = './out/obj/'
        FileUtils.mkdir_p(directory)

        objects.each_value do |instance|
            new_path = "#{directory}/#{instance.short_id}.#{instance.format}"
            FileUtils.cp(instance.file, new_path)
        end
    end

    def import_common_assets
        import_styles
        import_images
        import_scripts
    end

private

    def import_styles
        directory = './out/css/'
        FileUtils.mkdir_p(directory)

        FileUtils.cp('assets/css/person.css', directory)
        FileUtils.cp('assets/css/source.css', directory)
        FileUtils.cp('assets/css/base.css',   directory)
        FileUtils.cp('assets/css/tree.css',   directory)
        FileUtils.cp('assets/css/list.css',   directory)
    end

    def import_images
        directory = './out/img/'
        FileUtils.mkdir_p(directory)

        FileUtils.cp('assets/img/rings-black.png', directory)
    end

    def import_scripts
        directory = './out/js/'
        FileUtils.mkdir_p(directory)

        FileUtils.cp('assets/js/leader-line.min.js', directory)
        FileUtils.cp('assets/js/pagemap.min.js', directory)
        FileUtils.cp('assets/js/minimap.js', directory)
    end
end
