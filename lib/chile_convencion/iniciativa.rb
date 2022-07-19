# frozen_string_literal: true

module ChileConvencion
  # Iniciativa Popular de Norma
  class Iniciativa
    attr_reader :id, :title, :comision, :topic, :publication_date,
                :support_count, :type, :author, :organization, :url

    BASE_URL = 'https://plataforma.chileconvencion.cl/m/iniciativa_popular/'

    # Initialize with data from
    #   - https://plataforma.chileconvencion.cl/m/iniciativa_popular/iniciativas.csv
    #   - https://plataforma.chileconvencion.cl/m/iniciativa_indigena/iniciativas.csv
    def initialize(csv_row)
      @id, @title, @comision, @topic, @publication_date,
      @support_count, @type, @author, @organization, @url = csv_row.fields
    end

    def details_url
      "#{BASE_URL}detalle?id=#{@id}"
    end

    def stats_url
      "#{BASE_URL}stats?id=#{@id}"
    end
  end
end
