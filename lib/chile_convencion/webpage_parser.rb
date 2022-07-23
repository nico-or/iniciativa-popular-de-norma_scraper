# frozen_string_literal: true

require 'nokogiri'

module ChileConvencion
  # Parent class for webpage parser classes
  class WebpageParser
    def initialize(html)
      @parsed = Nokogiri(html)
    end
  end
end
