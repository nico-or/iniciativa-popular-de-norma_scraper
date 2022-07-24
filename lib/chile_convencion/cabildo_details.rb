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

    def conclusiones
      conclusion_elements.map { ChileConvencion::Conclusion.new(_1) }
    end

    private

    def conclusion_elements
      a = @parsed.css('div#encuentro h2').map(&:text)
      b = @parsed.css('div#encuentro h2+p').map(&:text)
      c = @parsed.css('div#encuentro h2+p+p').map(&:text)
      a.zip(b, c)
    end
  end
end
