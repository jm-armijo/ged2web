require_relative 'record'
require_relative 'record_decorator'
require_relative 'records/event'
require_relative 'records/family'
require_relative 'records/head'
require_relative 'records/multimedia'
require_relative 'records/name'
require_relative 'records/note'
require_relative 'records/person'
require_relative 'records/pointer'
require_relative 'records/source'
require_relative 'records/submission'
require_relative 'records/text'

class RecordFactory
    def self.make(line)
        return create_instance(line)
    rescue StandardError => e
        raise "Do not know how to make a #{line.tag} record #{line.level}: #{e}"
    end

    def self.create_instance(line)
        class_to_instantiate = get_class_to_instantiate(line)
        return class_to_instantiate.new(line)
    end

    def self.get_class_to_instantiate(line)
        tag = line.tag.to_sym

        if line.level.zero?
            class_to_instantiate = @base_records_map[tag]
        else
            class_to_instantiate = @internal_records_map[tag]
        end

        return class_to_instantiate
    end

    @base_records_map = {
        HEAD: Head,
        FAM:  Family,
        INDI: Person,
        NOTE: Note,
        OBJE: Multimedia,
        SOUR: Source,
        SUBM: Submission,
        TRLR: RecordDecorator
    }

    @internal_records_map = {
        ADOP: Event,
        ANUL: Event,
        BAPL: Event,
        BAPM: Event,
        BARM: Event,
        BASM: Event,
        BIRT: Event,
        BLES: Event,
        BURI: Event,
        CENS: Event,
        CHRA: Event,
        CHR:  Event,
        CREM: Event,
        DEAT: Event,
        DIV:  Event,
        DIVF: Event,
        EMIG: Event,
        ENGA: Event,
        EVEN: Event,
        FCOM: Event,
        GRAD: Event,
        IMMI: Event,
        MARB: Event,
        MARC: Event,
        MARL: Event,
        MARR: Event,
        MARS: Event,
        NATU: Event,
        ONF:  Event,
        ORDN: Event,
        PROB: Event,
        RESI: Event,
        RETI: Event,
        WILL: Event,
        FAMC: Pointer,
        FAMS: Pointer,
        HUSB: Pointer,
        NOTE: Pointer,
        OBJE: Pointer,
        SOUR: Pointer,
        WIFE: Pointer,
        NAME: Name,
        TEXT: Text
    }
    @internal_records_map.default = RecordDecorator
end
