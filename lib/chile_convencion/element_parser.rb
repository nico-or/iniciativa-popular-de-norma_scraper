# frozen_string_literal: true

module ChileConvencion
  # Parent class for Nokogiri element parsers classes
  class ElementParser
    def initialize(nokogiri_element)
      @element = nokogiri_element
    end
  end
end
