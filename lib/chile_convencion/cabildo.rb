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

    private

    def relative_path
      @element.css('a.boton').first.attr(:href)
    end
  end
end
