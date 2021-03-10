require_relative 'file_manager'

class Section
    @file_manager = FileManager.instance

    def self.build_ref_ids(references)
        return '' if references.length.zero?

        template = @file_manager.open_template('reference_ids.html')
        return template.result(binding)
    end
end
