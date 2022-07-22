# frozen_string_literal: true

module ChileConvencion
  # IDs obtained from
  # https://plataforma.chileconvencion.cl/m/iniciativa_popular/aprobadas
  APROBADAS = %w[
    8590 5502 45286 5938 5930 4138 34 3042 40230 4102 47662
    8618 1650 20654 4758 5602 13394 3182 41694 40494 41126 22338
    9414 5542 71442 45658 38 9026 10898 36582 50754 3422 3694
    56422 11402 43982 18394 874 43926 55950 38866 57970 6470 33622
    45570 10234 10218 71122 48358 43538 41474 2826 15150 36618 7062
    41318 3006 57370 48926 3430 73838 59750 4738 41466 14698 17046
    46746 47446 4126 70062 8082 6466 18202 19350 11050 9638 45166
  ].freeze

  # Iniciativa Popular de Norma
  class Iniciativa
    attr_reader :id, :title, :comision, :topic, :publication_date,
                :support_count, :type, :author, :organization, :url

    # Initialize with data from
    #   - https://plataforma.chileconvencion.cl/m/iniciativa_popular/iniciativas.csv
    #   - https://plataforma.chileconvencion.cl/m/iniciativa_indigena/iniciativas.csv
    def initialize(csv_row, type)
      raise unless ['popular', 'indigena'].include? type

      @id, @title, @comision, @topic, @publication_date,
      @support_count, @type, @author, @organization, @url = csv_row.fields

      @type = type
    end

    def details_url
      "#{base_url}detalle?id=#{@id}"
    end

    def stats_url
      "#{base_url}stats?id=#{@id}"
    end

    def aprobada?
      APROBADAS.include? @id
    end

    def indigena?
      type.eql? 'indigena'
    end

    def popular?
      type.eql? 'popular'
    end

    private

    def base_url
      "https://plataforma.chileconvencion.cl/m/iniciativa_#{type}/"
    end
  end
end
