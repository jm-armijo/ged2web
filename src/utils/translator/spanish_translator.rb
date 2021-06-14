class SpanishTranslator
    def self.translate(key)
        map = {
            ''            => '',
            'es'          => 'español',
            'sunday'      => 'domingo',
            'monday'      => 'lunes',
            'tuesday'     => 'martes',
            'wednesday'   => 'miércolesi',
            'thursday'    => 'jueves',
            'friday'      => 'viernes',
            'saturday'    => 'sábado',
            'january'     => 'enero',
            'february'    => 'febrero',
            'march'       => 'marzo',
            'april'       => 'abril',
            'may'         => 'mayo',
            'june'        => 'junio',
            'july'        => 'julio',
            'august'      => 'agosto',
            'september'   => 'septiembre',
            'october'     => 'octubre',
            'november'    => 'noviembre',
            'december'    => 'diciembre',
            'family_tree' => 'árbol genealógico',
            'view'        => 'ver',
            'tree'        => 'árbol',
            'index'       => 'índice',
            'first_name'  => 'nombre',
            'last_name'   => 'apellido',
            'abbr'        => 'abreviación',
            'abt'         => 'aproximada',
            'addr'        => 'dirección',
            'adop'        => 'adopción',
            'adr1'        => 'dirección1',
            'adr2'        => 'dirección2',
            'afn'         => 'afn',
            'aft'         => 'después',
            'age'         => 'edad',
            'agnc'        => 'agencia',
            'alia'        => 'alias',
            'ance'        => 'ancestros',
            'anci'        => 'interes en ancestros',
            'and'         => 'y',
            'anul'        => 'anulación',
            'asso'        => 'asociados',
            'auth'        => 'autor',
            'bapl'        => 'bautismo lds',
            'bapm'        => 'bautismo',
            'barm'        => 'bar mitzvah',
            'basm'        => 'bas mitzvah',
            'bef'         => 'antes',
            'bet'         => 'entre',
            'birt'        => 'nacimiento',
            'bles'        => 'bendición',
            'buri'        => 'entierro',
            'cal'         => 'calculada',
            'caln'        => 'número de colección',
            'cast'        => 'casta',
            'caus'        => 'causa',
            'cens'        => 'censo',
            'chan'        => 'cambio',
            'char'        => 'conjunto de caracteres',
            'chil'        => 'hijo/a',
            'chra'        => 'bautismo adulto',
            'chr'         => 'bautismo',
            'city'        => 'ciudad',
            'conc'        => 'concatenación',
            'conf'        => 'confirmación',
            'conl'        => 'confirmación lds',
            'cont'        => 'continuado',
            'copr'        => 'derechos de autor',
            'corp'        => 'corporación',
            'crem'        => 'cremación',
            'ctry'        => 'país',
            'data'        => 'datos',
            'date'        => 'fecha',
            'deat'        => 'muerte',
            'desc'        => 'descendientes',
            'desi'        => 'interés en descendientes',
            'dest'        => 'destino',
            'div'         => 'divorcio',
            'divf'        => 'divorcio presentado',
            'dscr'        => 'descripción física',
            'educ'        => 'educación',
            'emai'        => 'email',
            'emig'        => 'emigración',
            'endl'        => 'dote',
            'enga'        => 'compromiso',
            'even'        => 'evento',
            'est'         => 'estimada',
            'fact'        => 'hecho',
            'famc'        => 'hijo/a de familia',
            'fam'         => 'familia',
            'famf'        => 'archivo de familia',
            'fams'        => 'esposo/a de familia',
            'father'      => 'padre',
            'fax'         => 'facsímil',
            'fcom'        => 'primera comunión',
            'f'           => 'femenino',
            'file'        => 'archivo',
            'fone'        => 'fonético',
            'form'        => 'formato',
            'gedc'        => 'gedcom',
            'givn'        => 'nombre propio',
            'grad'        => 'graduación',
            'head'        => 'encabezado',
            'husb'        => 'esposo',
            'idno'        => 'número de identificación',
            'immi'        => 'inmigración',
            'indi'        => 'individuo',
            'lang'        => 'idioma',
            'lati'        => 'latitud',
            'long'        => 'longitud',
            'map'         => 'mapa',
            'marb'        => 'anuncio de matrimonio',
            'marc'        => 'contrato de matrimonio',
            'marl'        => 'licencia de matrimonio',
            'marr'        => 'matrimonio',
            'mars'        => 'acuerdo matrimonial',
            'medi'        => 'media',
            'm'           => 'masculino',
            'mother'      => 'madre',
            'name'        => 'nombre',
            'nati'        => 'nacionalidad',
            'natu'        => 'naturalización',
            'nchi'        => 'número de hijos',
            'nick'        => 'apodo',
            'nmr'         => 'número de matrimonios',
            'note'        => 'nota',
            'npfx'        => 'prefijo de nombre',
            'nsfx'        => 'sufijo de nombre',
            'obje'        => 'objeto',
            'occu'        => 'ocupación',
            'ordi'        => 'ordenanza',
            'ordn'        => 'ordenación',
            'page'        => 'página',
            'pedi'        => 'linaje',
            'phon'        => 'teléfono',
            'plac'        => 'lugar',
            'post'        => 'código postal',
            'prob'        => 'legalización de testamento',
            'prop'        => 'propiedad',
            'publ'        => 'publicación',
            'quay'        => 'calidad de los datos',
            'refn'        => 'referencia',
            'rela'        => 'relación',
            'reli'        => 'religion',
            'repo'        => 'repositorio',
            'resi'        => 'residencia',
            'resn'        => 'restricción',
            'reti'        => 'jubilación',
            'rfn'         => 'número de archivo del registro',
            'rin'         => 'nùmero de identificación del registro',
            'role'        => 'rol',
            'romn'        => 'romanizado',
            'sex'         => 'género',
            'slgc'        => 'sellamiento de hijo/a',
            'slgs'        => 'sellamiento de esposa/a',
            'sources'     => 'fuentes',
            'sour'        => 'fuente',
            'spfx'        => 'prefijo de apellido',
            'ssn'         => 'número de seguridad social EE.UU.',
            'stae'        => 'estado',
            'stat'        => 'estado',
            'subm'        => 'remitente',
            'subn'        => 'envío',
            'surn'        => 'apellido',
            'temp'        => 'templo',
            'text'        => 'texto',
            'time'        => 'hora',
            'titl'        => 'título',
            'trlr'        => 'fin del archivo',
            'type'        => 'tipo',
            'vers'        => 'versión',
            'wife'        => 'esposa',
            'will'        => 'testamento'
        }

        return map[key] if map.key?(key)

        raise "Can't translate '#{key}' into Spanish"
    end
end
