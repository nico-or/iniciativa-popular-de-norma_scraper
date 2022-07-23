# frozen_string_literal: true

require 'csv'

require_relative 'helpers'
require_relative 'chile_convencion/webpage_parser'
require_relative 'chile_convencion/element_parser'
require_relative 'chile_convencion/iniciativa'
require_relative 'chile_convencion/details_page'
require_relative 'chile_convencion/stats_page'
require_relative 'chile_convencion/script_tag'
require_relative 'chile_convencion/cabildo'
require_relative 'chile_convencion/cabildo_details'
require_relative '../db/database'

module ChileConvencion
  # Load iniciativas CSV data
  # Input:
  #   - type: String (popular/indigena)
  def self.load_iniciativas(type)
    rows = CSV.open("./data/iniciativa_#{type}_norma.csv", headers: true)
    rows.map { |row| ChileConvencion::Iniciativa.new(row, type) }
  end

  def self.load_cabildos
    index = Nokogiri(File.read('data/index_cabildos.html'))
    index.css('#actas .acta').map { |card| Cabildo.new(card) }
  end
end
