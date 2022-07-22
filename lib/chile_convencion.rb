# frozen_string_literal: true

require 'csv'

require_relative 'chile_convencion/iniciativa'
require_relative 'chile_convencion/details_page'
require_relative 'chile_convencion/stats_page'
require_relative 'chile_convencion/script_tag'
require_relative '../db/database'

module ChileConvencion
  # Load iniciativas CSV data
  # Input:
  #   - type: String (popular/indigena)
  def self.load_iniciativas(type)
    rows = CSV.open("./data/iniciativa_#{type}_norma.csv", headers: true)
    rows.map { |row| ChileConvencion::Iniciativa.new(row, type) }
  end
end
