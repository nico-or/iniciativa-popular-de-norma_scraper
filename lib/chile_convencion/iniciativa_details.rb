# frozen_string_literal: true

module ChileConvencion
  # Parser for Iniciativa Details webpage
  class IniciativaDetails < WebpageParser
    def respuestas
      @parsed.css('#propuesta p').map(&:text)
    end
  end
end
