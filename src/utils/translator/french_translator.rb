class FrenchTranslator
    def self.translate(key)
        map = {
            ''            => '',
            'fr'          => 'french',
            'sunday'      => 'dimanche',
            'monday'      => 'lundi',
            'tuesday'     => 'mardi',
            'wednesday'   => 'mercredi',
            'thursday'    => 'jeudi',
            'friday'      => 'vendredi',
            'saturday'    => 'samedi',
            'january'     => 'janvier',
            'february'    => 'février',
            'march'       => 'mars',
            'april'       => 'avril',
            'may'         => 'mai',
            'june'        => 'juin',
            'july'        => 'juillet',
            'august'      => 'août',
            'september'   => 'septembre',
            'october'     => 'octobre',
            'november'    => 'novembre',
            'december'    => 'décembre',
            'family_tree' => 'arbre généalogique',
            'built_with'  => 'construit avec',
            'view'        => 'voir',
            'tree'        => 'arbre',
            'index'       => 'indice',
            'first_name'  => 'nom',
            'last_name'   => 'prénom',
            'abbr'        => 'abréviation',
            'abt'         => 'approximative.',
            'addr'        => 'adresse',
            'adop'        => 'adoption',
            'adr1'        => 'adresse 1',
            'adr2'        => 'adresse 2',
            'afn'         => 'afn',
            'aft'         => 'après',
            'age'         => 'âge',
            'agnc'        => 'agence',
            'alia'        => 'alias',
            'ance'        => 'ancêtres',
            'anci'        => 'intérêt pour ancêtres',
            'and'         => 'et',
            'anul'        => 'annulation',
            'asso'        => 'partenaires',
            'auth'        => 'auteur',
            'bapl'        => 'baptême lds',
            'bapm'        => 'baptême',
            'barm'        => 'bar mitzvah',
            'basm'        => 'bas mitzvah',
            'bef'         => 'avant',
            'bet'         => 'entre',
            'birt'        => 'naissance',
            'bles'        => 'bénédiction',
            'buri'        => 'enterrement',
            'cal'         => 'calculée',
            'caln'        => 'numéro de collection',
            'cast'        => 'caste',
            'caus'        => 'cause',
            'cens'        => 'recensement',
            'chan'        => 'changement',
            'char'        => 'jeu de caractères',
            'chil'        => 'enfant',
            'chra'        => 'baptême adulte',
            'chr'         => 'baptême',
            'city'        => 'ville',
            'conc'        => 'concaténation',
            'conf'        => 'confirmation',
            'conl'        => 'confirmation lds',
            'cont'        => 'continué',
            'copr'        => 'droit d\'auteur',
            'corp'        => 'corporation',
            'crem'        => 'crémation',
            'ctry'        => 'pays',
            'data'        => 'données',
            'date'        => 'date',
            'deat'        => 'décès',
            'desc'        => 'descendants',
            'desi'        => 'intérêt pour descendants',
            'dest'        => 'destination ',
            'div'         => 'divorce',
            'divf'        => 'divorce demandé',
            'dscr'        => 'description physique',
            'educ'        => 'éducation',
            'emai'        => 'email',
            'emig'        => 'émigration',
            'endl'        => 'dot',
            'enga'        => 'fiançailles',
            'even'        => 'événement',
            'est'         => 'estimée',
            'fact'        => 'fait',
            'famc'        => 'enfants de famille',
            'fam'         => 'famille',
            'famf'        => 'dossiers de la famille',
            'fams'        => 'époux/épouse de la famille',
            'father'      => 'père',
            'fax'         => 'télécopie',
            'fcom'        => 'première communion',
            'f'           => 'féminin',
            'file'        => 'fichier',
            'fone'        => 'phonétique',
            'form'        => 'format',
            'gedc'        => 'gedcom',
            'givn'        => 'nom personnel',
            'grad'        => 'diplôme',
            'head'        => 'en-tête',
            'husb'        => 'époux',
            'idno'        => 'numéro d\'identification',
            'immi'        => 'immigration',
            'indi'        => 'individu',
            'lang'        => 'idioma',
            'lati'        => 'langue',
            'long'        => 'longitude',
            'map'         => 'carte',
            'marb'        => 'publication des bans',
            'marc'        => 'contrat de mariage',
            'marl'        => 'autorisation de mariage',
            'marr'        => 'mariage',
            'mars'        => 'contrat de mariage',
            'medi'        => 'multimédia',
            'm'           => 'masculin',
            'mother'      => 'mère',
            'name'        => 'nom',
            'nati'        => 'nationalité',
            'natu'        => 'naturalisation',
            'nchi'        => 'nombre d\'enfants',
            'nick'        => 'surnom',
            'nmr'         => 'nombre de mariages',
            'note'        => 'note',
            'npfx'        => 'préfixe du nom',
            'nsfx'        => 'suffixe de nom',
            'obje'        => 'objet',
            'occu'        => 'occupation',
            'ordi'        => 'ordonnance',
            'ordn'        => 'ordination',
            'page'        => 'page',
            'pedi'        => 'lignée',
            'phon'        => 'téléphone',
            'plac'        => 'lieu',
            'post'        => 'code postal',
            'prob'        => 'validation de testament',
            'prop'        => 'propriété',
            'publ'        => 'publication',
            'quay'        => 'qualité des données',
            'refn'        => 'référence',
            'rela'        => 'relation',
            'reli'        => 'religión',
            'repo'        => 'dépôt',
            'resi'        => 'résidence',
            'resn'        => 'restriction',
            'reti'        => 'retraite',
            'rfn'         => 'numéro de fichier de dossier',
            'rin'         => 'numéro d\'identification de registro',
            'role'        => 'rôle',
            'romn'        => 'romanisé',
            'sex'         => 'genre',
            'slgc'        => 'scellement aux enfants',
            'slgs'        => 'scellement aux parents',
            'sources'     => 'sources',
            'sour'        => 'source',
            'spfx'        => 'préfixe du nom',
            'ssn'         => 'numéro de sécurité sociale États-Unis',
            'stae'        => 'état',
            'stat'        => 'état',
            'subm'        => 'expéditeur',
            'subn'        => 'envoi',
            'surn'        => 'nom',
            'temp'        => 'temple',
            'text'        => 'texte',
            'time'        => 'heure',
            'titl'        => 'titre',
            'trlr'        => 'fin du fichier',
            'type'        => 'type',
            'u'           => 'indéfini',
            'vers'        => 'version',
            'wife'        => 'épouse',
            'will'        => 'testament'
        }

        return map[key] if map.key?(key)

        raise "Can't translate '#{key}' into French"
    end
end
