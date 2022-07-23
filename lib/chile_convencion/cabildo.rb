module ChileConvencion
  # Cabildo o Encuentro
  class Cabildo < ElementParser
    BASE_URL = 'https://plataforma.chileconvencion.cl/m/cabildos/'

    def details_url
      URI.join(BASE_URL, relative_path).to_s
    end

    %w[tipo id fecha].each_with_index do |method, index|
      define_method(method) do
        instance_variable_set("@#{method}", h2_elements[index + 1])
      end
    end

    def nombre
      @nombre ||= @element.css('h1').text
    end

    def modalidad
      li_elements[0]
    end

    def num_participantes
      li_elements[1]
    end

    def ubicacion
      li_elements[3]
    end

    private

    def relative_path
      @element.css('a.boton').first.attr(:href)
    end

    def h2_elements
      # Matches a line like:
      # Cabildo comunal Nº 806 - 12/01/2022
      regex = /(.*) N.+ (\d+) - (.*)/
      regex.match @element.css('h2').text
    end

    def li_elements
      # Matches a line like:
      # foo: bar
      regex = /:\s+(.+)/

      @element
        .css('li')
        .map(&:text)
        .map { regex.match _1 }
        .map { _1[1] }
        .map(&:strip)
    end
  end
end
