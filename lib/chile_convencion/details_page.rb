# frozen_string_literal: true

module ChileConvencion
  # Parser for Iniciativa Details webpage
  class DetailsPage < WebpageParser
    def respuestas
      @parsed.css('#propuesta p').map(&:text)
    end
  end
end
