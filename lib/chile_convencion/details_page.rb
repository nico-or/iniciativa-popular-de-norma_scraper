# frozen_string_literal: true

require 'nokogiri'

module ChileConvencion
  # Parser for Iniciativa webpages
  class DetailsPage
    def initialize(html)
      @parsed = Nokogiri html
    end

    def respuestas
      @parsed.css('#propuesta p').map(&:text)
    end
  end
end