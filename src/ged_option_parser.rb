require 'optparse'

Options = Struct.new(:gedcom)

class GedOptionParser
    def parse(options)
        @args = Options.new

        begin
            check_mandatory_args(options)
            parser.parse!(options)
        rescue OptionParser::MissingArgument => e
            handle_exception('MissingArgumentError', e.message)
        rescue OptionParser::InvalidOption => e
            handle_exception('InvalidOptionError', e.message)
        end

        return @args
    end

private

    def parser
        return OptionParser.new do |opts|
            opts.banner = 'Usage: run.rb [options]'

            opts.on('-gGEDCOM', '--gedcom=GEDCOM', 'Path to input gedcom file') do |n|
                @args.gedcom = n
            end

            opts.on_tail('-h', '--help', 'Prints this help') do
                puts opts
                exit
            end
        end
    end

    def handle_exception(error, message)
        puts "#{error}: #{message}\n\n"
        parser.parse!(['-h'])
    end

    def check_mandatory_args(options)
        raise(OptionParser::MissingArgument, '-g') if options.length.zero?
    end
end
