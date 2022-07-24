# frozen_string_literal: true

require_relative 'chile_convencion/webpage_parser'
require_relative 'chile_convencion/element_parser'
require_relative 'chile_convencion/iniciativa_details'
require_relative 'chile_convencion/iniciativa_stats'
require_relative 'chile_convencion/cabildo_details'
require_relative 'chile_convencion/iniciativa'
require_relative 'chile_convencion/script_tag'
require_relative 'chile_convencion/cabildo'
require_relative '../db/database'
require_relative 'helpers'

module ChileConvencion
  def self.load_iniciativas(type)
    index = Nokogiri(File.read("data/index_iniciativa_#{type}.html"))
    index.css('#iniciativas .iniciativa').map { |card| Iniciativa.new(card, type) }
  end

  def self.load_all_iniciativas
    %w[indigena popular]
      .map { |type| load_iniciativas(type) }
      .flatten
  end

  def self.load_cabildos
    index = Nokogiri(File.read('data/index_cabildos.html'))
    index.css('#actas .acta').map { |card| Cabildo.new(card) }
  end

  def self.download_urls
    foo = []
    foo += load_all_iniciativas
    foo += load_cabildos
    foo.flat_map(&:download_urls)
  end
end
