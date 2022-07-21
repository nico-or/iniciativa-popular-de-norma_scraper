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
      data_script_tags[1]
    end

    def data_script_tags
      @data_script_tags_memo ||= parsed.css('script').select { _1.children.text.match? /addRows/ }

      @data_script_tags_memo.map do |script_tag|
        script_tag_entries(script_tag_data(script_tag)).map do |entry|
          parse_data_entry(entry)
        end
      end
    end

    def entry_regex
      /\[" (.*?)",(\d+)/
    end

    def script_tag_data(script_tag)
      data_entries_regex = /addRows\( \[(.*)\] \)/
      (script_tag.text.match data_entries_regex)[1]
    end

    def script_tag_entries(text)
      split_entries_regex = /(?<=\]),(?=\[)/
      text.split(split_entries_regex)
    end

    def parse_data_entry(entry)
      match = entry_regex.match entry
      [match[1], match[2]]
    end
  end
end
