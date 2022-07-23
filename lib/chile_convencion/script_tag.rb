# frozen_string_literal: true

module ChileConvencion
  # Parser for the HTML script tags that contains the stats data
  class ScriptTag < ElementParser
    def entries
      @entries ||= splitted_entries.map { |e| parse_entry(e) }
    end

    private

    def raw_data
      regex = /addRows\( \[(.*)\]\s?\)/
      (@element.text.match regex)[1]
    end

    def splitted_entries
      regex = /(?<=\]),(?=\[)/
      raw_data.split(regex)
    end

    def parse_entry(entry)
      regex = /\[" (.*?)",(\d+)/
      match = regex.match entry
      [match[1], match[2]]
    end
  end
end
