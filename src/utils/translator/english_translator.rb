class EnglishTranslator
    def self.translate(key)
        map = {
            ''            => '',
            'en'          => 'english',
            'sunday'      => 'sunday',
            'monday'      => 'monday',
            'tuesday'     => 'tuesday',
            'wednesday'   => 'wednesday',
            'thursday'    => 'thursday',
            'friday'      => 'friday',
            'saturday'    => 'saturday',
            'january'     => 'January',
            'february'    => 'February',
            'march'       => 'March',
            'april'       => 'April',
            'may'         => 'May',
            'june'        => 'June',
            'july'        => 'July',
            'august'      => 'August',
            'september'   => 'September',
            'october'     => 'October',
            'november'    => 'November',
            'december'    => 'December',
            'family_tree' => 'family tree',
            'view'        => 'view',
            'tree'        => 'tree',
            'list'        => 'list',
            'first_name'  => 'first name',
            'last_name'   => 'last name',
            'abbr'        => 'abbreviation',
            'abt'         => 'about',
            'addr'        => 'address',
            'adop'        => 'adoption',
            'adr1'        => 'address1',
            'adr2'        => 'address2',
            'afn'         => 'afn',
            'aft'         => 'after',
            'age'         => 'age',
            'agnc'        => 'agency',
            'alia'        => 'alias',
            'ance'        => 'ancestors',
            'anci'        => 'interest in ancestors',
            'and'         => 'and',
            'anul'        => 'annulment',
            'asso'        => 'associates',
            'auth'        => 'author',
            'bapl'        => 'baptism-lds',
            'bapm'        => 'baptism',
            'barm'        => 'bar mitzvah',
            'basm'        => 'bas mitzvah',
            'bef'         => 'before',
            'bet'         => 'between',
            'birt'        => 'birth',
            'bles'        => 'blessing',
            'buri'        => 'burial',
            'cal'         => 'calculated',
            'caln'        => 'collection number',
            'cast'        => 'caste',
            'caus'        => 'cause',
            'cens'        => 'census',
            'chan'        => 'change',
            'char'        => 'character',
            'chil'        => 'child',
            'chra'        => 'adult christening',
            'chr'         => 'christening',
            'city'        => 'city',
            'conc'        => 'concatenation',
            'conf'        => 'confirmation',
            'conl'        => 'confirmation lds',
            'cont'        => 'continued',
            'copr'        => 'copyright',
            'corp'        => 'corporate',
            'crem'        => 'cremation',
            'ctry'        => 'country',
            'data'        => 'data',
            'date'        => 'date',
            'deat'        => 'death',
            'desc'        => 'descendants',
            'desi'        => 'interest in descendants',
            'dest'        => 'destination',
            'div'         => 'divorce',
            'divf'        => 'divorce filed',
            'dscr'        => 'physical description',
            'educ'        => 'education',
            'emai'        => 'email',
            'emig'        => 'emigration',
            'endl'        => 'endowment',
            'enga'        => 'engagement',
            'even'        => 'event',
            'est'         => 'estimated',
            'fact'        => 'fact',
            'famc'        => 'family child',
            'fam'         => 'family',
            'famf'        => 'family file',
            'fams'        => 'family spouse',
            'father'      => 'father',
            'fax'         => 'facimilie',
            'fcom'        => 'first communion',
            'f'           => 'female',
            'file'        => 'file',
            'fone'        => 'phonetic',
            'form'        => 'format',
            'gedc'        => 'gedcom',
            'givn'        => 'given name',
            'grad'        => 'graduation',
            'head'        => 'header',
            'husb'        => 'husband',
            'idno'        => 'identity number',
            'immi'        => 'immigration',
            'indi'        => 'individual',
            'lang'        => 'language',
            'lati'        => 'latitude',
            'long'        => 'longitude',
            'map'         => 'map',
            'marb'        => 'marriage bann',
            'marc'        => 'marriage contract',
            'marl'        => 'marriage license',
            'marr'        => 'marriage',
            'mars'        => 'marriage settlement',
            'medi'        => 'media',
            'm'           => 'male',
            'mother'      => 'mother',
            'name'        => 'name',
            'nati'        => 'nationality',
            'natu'        => 'naturalization',
            'nchi'        => 'children count',
            'nick'        => 'nickname',
            'nmr'         => 'marriage count',
            'note'        => 'note',
            'npfx'        => 'name prefix',
            'nsfx'        => 'name suffix',
            'obje'        => 'object',
            'occu'        => 'occupation',
            'ordi'        => 'ordinance',
            'ordn'        => 'ordination',
            'page'        => 'page',
            'pedi'        => 'pedigree',
            'phon'        => 'phone',
            'plac'        => 'place',
            'post'        => 'postal code',
            'prob'        => 'probate',
            'prop'        => 'property',
            'publ'        => 'publication',
            'quay'        => 'quality of data',
            'refn'        => 'reference',
            'rela'        => 'relationship',
            'reli'        => 'religion',
            'repo'        => 'repository',
            'resi'        => 'residence',
            'resn'        => 'restriction',
            'reti'        => 'retirement',
            'rfn'         => 'record file number',
            'rin'         => 'record id number',
            'role'        => 'role',
            'romn'        => 'romanized',
            'sex'         => 'gender',
            'slgc'        => 'sealing child',
            'slgs'        => 'sealing spouse',
            'sources'     => 'sources',
            'sour'        => 'source',
            'spfx'        => 'surname prefix',
            'ssn'         => 'social security number USA',
            'stae'        => 'state',
            'stat'        => 'status',
            'subm'        => 'submitter',
            'subn'        => 'submission',
            'surn'        => 'surname',
            'temp'        => 'temple',
            'text'        => 'text',
            'time'        => 'time',
            'titl'        => 'title',
            'trlr'        => 'trailer',
            'type'        => 'type',
            'vers'        => 'version',
            'wife'        => 'wife',
            'will'        => 'will'
        }

        return map[key] if map.key?(key)

        raise "Can't translate '#{key}' into English"
    end
end