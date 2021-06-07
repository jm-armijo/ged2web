require 'singleton'
require_relative 'ged/ged'
require_relative 'tree/tree_builder'
require_relative 'list/list_builder'
require_relative 'web/builder'

class Main
    include Singleton

    def execute(path, languages)
        ged = parse_ged_file(path)
        build_site(ged, languages)
    end

private

    def parse_ged_file(path)
        parser = Parser.new
        return parser.parse(path)
    end

    def build_site(ged, languages)
        builder = WebBuilder.new
        builder.build(ged, languages)
        builder.import_files(ged)
    end
end
