# frozen_string_literal: true

module ChileConvencion
  # Parser for Cabildo details webpage
  class Conclusion
    def initialize(array)
      @comision, @tema, @texto = array
    end

    def comision
      regex = /Conclusión \d+ (.*)/
      regex.match(@comision)[1]
    end

    def tema
      regex = /Tema: (.*)/
      regex.match(@tema)[1]
    end

    def texto
      @texto
    end
  end
end
