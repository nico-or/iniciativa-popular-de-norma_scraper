# frozen_string_literal: true

require 'nokogiri'

module ChileConvencion
  # Parser for Iniciativa Stats webpage
  class StatsPage
    attr_reader :parsed

    def initialize(html)
      @parsed = Nokogiri html
    end

    %i[
      apoyos_por_fecha apoyos_acumulados_por_fecha apoyos_por_hora
      edades identidad_de_genero grupos_de_interes apoyos_por_regiones
      top_10_comunas pueblos_originarios
    ].each.with_index do |name, index|
      define_method(name) do
        script_tag_entries(index + 1)
      end
    end

    private

    def data_script_tags
      @data_script_tags ||=
        parsed.css('script')
              .select { /addRows/.match? _1.text }
              .map { ScriptTag.new _1 }
    end

    def script_tag_entries(index)
      data_script_tags[index].entries
    end
  end
end
