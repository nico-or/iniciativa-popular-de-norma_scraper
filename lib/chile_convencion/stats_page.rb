# frozen_string_literal: true

require 'nokogiri'

module ChileConvencion
  # Parser for Iniciativa Stats webpage
  class StatsPage
    attr_reader :parsed

    def initialize(html)
      @parsed = Nokogiri html
    end
  end
end
