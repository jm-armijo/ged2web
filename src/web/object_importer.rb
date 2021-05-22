require_relative 'file_manager'

class ObjectImporter
    def initialize(ged)
        @ged = ged
    end

    def import
        import_objects
        import_assets
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

    def import_assets
        import_styles
        import_images
        import_scripts
    end

    def import_styles
        directory = './out/css/'
        FileUtils.mkdir_p(directory)

        FileUtils.cp('assets/css/person.css', directory)
        FileUtils.cp('assets/css/source.css', directory)
        FileUtils.cp('assets/css/base.css',   directory)
        FileUtils.cp('assets/css/tree.css',   directory)
    end

    def import_images
        directory = './out/img/'
        FileUtils.mkdir_p(directory)

        FileUtils.cp('assets/img/background.jpg', directory)
        FileUtils.cp('assets/img/face.png',       directory)
        FileUtils.cp('assets/img/rings.png',      directory)
    end

    def import_scripts
        directory = './out/js/'
        FileUtils.mkdir_p(directory)

        FileUtils.cp('assets/js/leader-line.min.js', directory)
        FileUtils.cp('assets/js/pagemap.min.js', directory)
        FileUtils.cp('assets/js/minimap.js', directory)
    end
end
