# frozen_string_literal: true

require 'forwardable'

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
  class Iniciativa < ElementParser
    attr_reader :type

    extend Forwardable

    def_delegators :details_page, :topic, :author, :organization

    def initialize(nokogiri_node, type)
      raise unless %w[popular indigena].include? type

      @type = type
      super(nokogiri_node)
    end

    def id
      (/(\d+)/.match(h1_element.get_attribute(:href)))[1]
    end

    def title
      h1_element.text.strip
    end

    def commission
      @element.css('.pill').text
    end

    def publication_date
      string = @element.css('div').first.get_attribute('data-fecha')
      DateTime.parse(string).strftime('%d/%m/%Y')
    end

    def support_count
      @element.css('div').first.get_attribute('data-apoyos').to_i
    end

    def details_url
      "#{base_url}detalle?id=#{id}"
    end

    def stats_url
      "#{base_url}stats?id=#{id}"
    end

    def aprobada?
      APROBADAS.include?(id) && popular?
    end

    %w[indigena popular].each do |method|
      define_method("#{method}?") do
        type.eql? method
      end
    end

    def stats_page?
      popular? && aprobada?
    end

    def details_page
      @details_page ||= ChileConvencion::IniciativaDetails.new html_body(details_url)
    end

    def stats_page
      raise 'Iniciativa without Stats Page' unless stats_page?

      @stats_page ||= ChileConvencion::IniciativaStats.new html_body(stats_url)
    end

    def download_urls
      urls = [details_url]
      urls << stats_url if stats_page?
      urls
    end

    private

    def h1_element
      @element.css('h1 a').first
    end

    def base_url
      "https://plataforma.chileconvencion.cl/m/iniciativa_#{type}/"
    end

    def html_body(url)
      Page.find(url: url).html
    end
  end
end
