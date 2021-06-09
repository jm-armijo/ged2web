require_relative './translator/english_translator'
require_relative './translator/spanish_translator'

class Translator
    def self.translate(language, raw_text)
        processed_text = raw_text.downcase.gsub(' ', '_')
        return translator(language).translate(processed_text)
    end

    def self.translator(language)
        map = {
            'en' => EnglishTranslator,
            'es' => SpanishTranslator
        }

        if map.key?(language)
            return map[language]
        else
            raise "Can't translate '#{language}': supported languages: #{map.keys}"
        end
    end
end
