# frozen_string_literal: true

require 'csv'

module ChileConvencionHelpers
  def load_iniciativa(name, type)
    entry = CSV.open("spec/fixtures/iniciativa_#{name}.csv", headers: true)
    ChileConvencion::Iniciativa.new(entry.first, type)
  end

  def load_webpage(name)
    File.read("./spec/fixtures/#{name}.html", encoding: 'ISO8859-1:UTF-8')
  end
end
