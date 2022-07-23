# frozen_string_literal: true

module ChileConvencion
  # Parser for Cabildo details webpage
  class CabildoDetails
    def initialize(html)
      @parsed = Nokogiri(html)
    end
  end
end
