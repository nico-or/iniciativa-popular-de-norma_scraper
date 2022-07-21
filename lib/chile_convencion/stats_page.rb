# frozen_string_literal: true

require 'nokogiri'

module ChileConvencion
  # Parser for Iniciativa Stats webpage
  class StatsPage
    attr_reader :parsed

    def initialize(html)
      @parsed = Nokogiri html
    end

    def data_script_tags
      @data_script_tags_memo ||= parsed.css('script').select { _1.children.text.match? /addRows/ }
    end

    def entry_regex
      /\[" (.*?)",(\d+)/
    end
  end
end
