# frozen_string_literal: true

require 'csv'

module ChileConvencionHelpers
  def load_iniciativa(type)
    entry = CSV.open("spec/fixtures/iniciativa_#{type}.csv", headers: true)
    ChileConvencion::Iniciativa.new entry.first
  end

  def load_webpage(name)
    File.read("./spec/fixtures/#{name}.html")
  end
end
