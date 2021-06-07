#!/usr/bin/env ruby

require_relative 'src/ged_option_parser'
require_relative 'src/main'

option_parser = GedOptionParser.new
options = option_parser.parse ARGV

languages = ['en']

main = Main.instance
main.execute(options.gedcom, languages)
