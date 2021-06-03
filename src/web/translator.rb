class Translator
    def self.translate(language, tag)
        function = tag.downcase.gsub(' ', '_')
        return translator(language).public_send(function)
    end

    def self.translator(language)
        map = {
            'en' => EnglishTranslator
        }

        if map.key?(language)
            return map[language]
        else
            raise "Can't translate '#{language}': supported languages: #{map.keys}"
        end
    end
end

class EnglishTranslator
    # Functions below are for non-gedcom text used on the site
    def self.family_tree
        return 'family tree'
    end

    def self.view
        return 'view'
    end

    def self.tree
        return 'tree'
    end

    def self.list
        return 'list'
    end

    def self.first_name
        return 'first name'
    end

    def self.last_name
        return 'last name'
    end

    # Functions below are for gedcom tags
    def self.abbr
        return 'abbreviation'
    end

    def self.abt
        return 'about'
    end

    def self.addr
        return 'address'
    end

    def self.adop
        return 'adoption'
    end

    def self.adr1
        return 'address1'
    end

    def self.adr2
        return 'address2'
    end

    def self.afn
        return 'afn'
    end

    def self.aft
        return 'after'
    end

    def self.age
        return 'age'
    end

    def self.agnc
        return 'agency'
    end

    def self.alia
        return 'alias'
    end

    def self.ance
        return 'ancestors'
    end

    def self.anci
        return 'ances_interest'
    end

    def self.and
        return 'and'
    end

    def self.anul
        return 'annulment'
    end

    def self.asso
        return 'associates'
    end

    def self.auth
        return 'author'
    end

    def self.bapl
        return 'baptism-lds'
    end

    def self.bapm
        return 'baptism'
    end

    def self.barm
        return 'bar_mitzvah'
    end

    def self.basm
        return 'bas_mitzvah'
    end

    def self.bef
        return 'before'
    end

    def self.bet
        return 'between'
    end

    def self.birt
        return 'birth'
    end

    def self.bles
        return 'blessing'
    end

    def self.buri
        return 'burial'
    end

    def self.cal
        return 'calculated'
    end

    def self.caln
        return 'call_number'
    end

    def self.cast
        return 'caste'
    end

    def self.caus
        return 'cause'
    end

    def self.cens
        return 'census'
    end

    def self.chan
        return 'change'
    end

    def self.char
        return 'character'
    end

    def self.chil
        return 'child'
    end

    def self.chra
        return 'adult_christening'
    end

    def self.chr
        return 'christening'
    end

    def self.city
        return 'city'
    end

    def self.conc
        return 'concatenation'
    end

    def self.conf
        return 'confirmation'
    end

    def self.conl
        return 'confirmation_lds'
    end

    def self.cont
        return 'continued'
    end

    def self.copr
        return 'copyright'
    end

    def self.corp
        return 'corporate'
    end

    def self.crem
        return 'cremation'
    end

    def self.ctry
        return 'country'
    end

    def self.data
        return 'data'
    end

    def self.date
        return 'date'
    end

    def self.deat
        return 'death'
    end

    def self.desc
        return 'descendants'
    end

    def self.desi
        return 'descendant_int'
    end

    def self.dest
        return 'destination'
    end

    def self.div
        return 'divorce'
    end

    def self.divf
        return 'divorce_filed'
    end

    def self.dscr
        return 'phy_description'
    end

    def self.educ
        return 'education'
    end

    def self.emai
        return 'email'
    end

    def self.emig
        return 'emigration'
    end

    def self.endl
        return 'endowment'
    end

    def self.enga
        return 'engagement'
    end

    def self.even
        return 'event'
    end

    def self.est
        return 'estimated'
    end

    def self.fact
        return 'fact'
    end

    def self.famc
        return 'family_child'
    end

    def self.fam
        return 'family'
    end

    def self.famf
        return 'family_file'
    end

    def self.fams
        return 'family_spouse'
    end

    def self.father
        return 'father'
    end

    def self.fax
        return 'facimilie'
    end

    def self.fcom
        return 'first_communion'
    end

    def self.f
        return 'female'
    end

    def self.file
        return 'file'
    end

    def self.fone
        return 'phonetic'
    end

    def self.form
        return 'format'
    end

    def self.gedc
        return 'gedcom'
    end

    def self.givn
        return 'given_name'
    end

    def self.grad
        return 'graduation'
    end

    def self.head
        return 'header'
    end

    def self.husb
        return 'husband'
    end

    def self.idno
        return 'ident_number'
    end

    def self.immi
        return 'immigration'
    end

    def self.indi
        return 'individual'
    end

    def self.lang
        return 'language'
    end

    def self.lati
        return 'latitude'
    end

    def self.long
        return 'longitude'
    end

    def self.map
        return 'map'
    end

    def self.marb
        return 'marriage_bann'
    end

    def self.marc
        return 'marr_contract'
    end

    def self.marl
        return 'marr_license'
    end

    def self.marr
        return 'marriage'
    end

    def self.mars
        return 'marr_settlement'
    end

    def self.medi
        return 'media'
    end

    def self.m
        return 'male'
    end

    def self.mother
        return 'mother'
    end

    def self.name
        return 'name'
    end

    def self.nati
        return 'nationality'
    end

    def self.natu
        return 'naturalization'
    end

    def self.nchi
        return 'children_count'
    end

    def self.nick
        return 'nickname'
    end

    def self.nmr
        return 'marriage_count'
    end

    def self.note
        return 'note'
    end

    def self.npfx
        return 'name_prefix'
    end

    def self.nsfx
        return 'name_suffix'
    end

    def self.obje
        return 'object'
    end

    def self.occu
        return 'occupation'
    end

    def self.ordi
        return 'ordinance'
    end

    def self.ordn
        return 'ordination'
    end

    def self.page
        return 'page'
    end

    def self.pedi
        return 'pedigree'
    end

    def self.phon
        return 'phone'
    end

    def self.plac
        return 'place'
    end

    def self.post
        return 'postal_code'
    end

    def self.prob
        return 'probate'
    end

    def self.prop
        return 'property'
    end

    def self.publ
        return 'publication'
    end

    def self.quay
        return 'quality_of_data'
    end

    def self.refn
        return 'reference'
    end

    def self.rela
        return 'relationship'
    end

    def self.reli
        return 'religion'
    end

    def self.repo
        return 'repository'
    end

    def self.resi
        return 'residence'
    end

    def self.resn
        return 'restriction'
    end

    def self.reti
        return 'retirement'
    end

    def self.rfn
        return 'rec_file_number'
    end

    def self.rin
        return 'rec_id_number'
    end

    def self.role
        return 'role'
    end

    def self.romn
        return 'romanized'
    end

    def self.sex
        return 'gender'
    end

    def self.slgc
        return 'sealing_child'
    end

    def self.slgs
        return 'sealing_spouse'
    end

    def self.sources
        return 'sources'
    end

    def self.sour
        return 'source'
    end

    def self.spfx
        return 'surn_prefix'
    end

    def self.ssn
        return 'soc_sec_number'
    end

    def self.stae
        return 'state'
    end

    def self.stat
        return 'status'
    end

    def self.subm
        return 'submitter'
    end

    def self.subn
        return 'submission'
    end

    def self.surn
        return 'surname'
    end

    def self.temp
        return 'temple'
    end

    def self.text
        return 'text'
    end

    def self.time
        return 'time'
    end

    def self.titl
        return 'title'
    end

    def self.trlr
        return 'trailer'
    end

    def self.type
        return 'type'
    end

    def self.vers
        return 'version'
    end

    def self.wife
        return 'wife'
    end

    def self.will
        return 'will'
    end
end
