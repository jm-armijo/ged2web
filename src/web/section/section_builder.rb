require_relative '../file_manager'

class SectionBuilder
    def self.template
        @file_manager = FileManager.instance
        return @file_manager.open_template(@file_name)
    end
end

class HeaderBuilder < SectionBuilder
    @file_name = 'header.html'

    def self.build(language, styles)
        return template.result(binding)
    end
end

class BannerBuilder < SectionBuilder
    @file_name = 'banner.html'

    def self.build(language, page)
        return template.result(binding)
    end
end

class FooterBuilder < SectionBuilder
    @file_name = 'footer.html'

    def self.build(language, page)
        return template.result(binding)
    end
end

class ReferencesBuilder < SectionBuilder
    @file_name = 'references.html'

    def self.build(language, references)
        return template.result(binding)
    end
end

class NotesBuilder < SectionBuilder
    @file_name = 'notes.html'

    def self.build(language, notes)
        return template.result(binding)
    end
end

class EventsBuilder < SectionBuilder
    @file_name = 'events.html'

    def self.build(language, events)
        return template.result(binding)
    end
end

class SourcesBuilder < SectionBuilder
    @file_name = 'sources.html'

    def self.build(language, sources)
        return template.result(binding)
    end
end
