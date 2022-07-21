# frozen_string_literal: true

require 'nokogiri'

module ChileConvencion
  # Parser for Iniciativa Stats webpage
  class StatsPage
    attr_reader :parsed

    def initialize(html)
      @parsed = Nokogiri html
    end

    def apoyos_por_fecha
      data_script_tags[1].entries
    end

    def data_script_tags
      @data_script_tags ||=
        parsed.css('script')
              .select { /addRows/.match? _1.text }
              .map { ScriptTag.new _1 }
    end
  end
end
