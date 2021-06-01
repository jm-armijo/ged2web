require_relative '../file_manager'

class SectionBuilder
    def self.template
        @file_manager = FileManager.instance
        return @file_manager.open_template(@file_name)
    end
end

class HeaderBuilder < SectionBuilder
    @file_name = 'header.html'

    def self.build(styles)
        return template.result(binding)
    end
end

class BannerBuilder < SectionBuilder
    @file_name = 'banner.html'

    def self.build
        return template.result(binding)
    end
end

class ReferencesBuilder < SectionBuilder
    @file_name = 'references.html'

    def self.build(references)
        return template.result(binding)
    end
end
