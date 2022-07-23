module ChileConvencion
  # Cabildo o Encuentro
  class Cabildo
    BASE_URL = 'https://plataforma.chileconvencion.cl/m/cabildos/'

    def initialize(nokogiri_element)
      @element = nokogiri_element
    end

    def details_url
      URI.join(BASE_URL, relative_path).to_s
    end

    def tipo
      @tipo ||= h2_elements[1]
    end

    def id
      @id ||= h2_elements[2]
    end

    def nombre
      @nombre ||= @element.css('h1').text
    end

    private

    def relative_path
      @element.css('a.boton').first.attr(:href)
    end

    def h2_elements
      # Matches a line like:
      # Cabildo comunal Nº 806 - 12/01/2022
      regex = /(.*) Nº (\d+) - (.*)/
      regex.match @element.css('h2').text
    end
  end
end
