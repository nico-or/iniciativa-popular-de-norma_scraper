# frozen_string_literal: true

module ChileConvencion
  # Parser for Iniciativa Details webpage
  class IniciativaDetails < WebpageParser
    def respuestas
      @parsed.css('#propuesta p').map(&:text)
    end

    def topic
      @parsed
        .css('.objeto h2 + p')
        .text
        .gsub(/\ATema:\s+/, '')
    end

    def author
      @parsed.css('.persona').first.text.strip
    end

    def organization
      node = @parsed.css('.org').first
      return if node.nil?

      node.text.strip
    end
  end
end
