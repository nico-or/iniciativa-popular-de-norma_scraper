# frozen_string_literal: true

module ChileConvencion
  # Parser for Cabildo details webpage
  class CabildoDetails < WebpageParser
    def temas_abordados
      @parsed
        .css('#encuentro h2 + p')
        .map(&:text)
        .map { _1.gsub(/\ATema: /, '') }
    end

    def participantes_validadores
      @parsed
        .css('.participantes li')
        .map(&:text)
        .map(&:strip)
    end
  end
end
