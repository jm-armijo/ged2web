require_relative 'file_manager'

class ObjectImporter
    def initialize(ged)
        @ged = ged
    end

    def import
        directory = './out/obj/'
        FileUtils.mkdir_p(directory)

        instances = @ged.records.filter { |_k, v| v.tag == 'OBJE' }

        instances.each_value do |instance|
            new_path = "#{directory}/#{instance.short_id}.#{instance.format}"
            FileUtils.cp(instance.file, new_path)
        end
    end
end
