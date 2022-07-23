# frozen_string_literal: true

require 'csv'

def load_iniciativa(name, type)
  entry = CSV.open("spec/fixtures/iniciativa_#{name}.csv", headers: true)
  ChileConvencion::Iniciativa.new(entry.first, type)
end

def load_webpage_fixture(name)
  load_webpage("./spec/fixtures/#{name}.html")
end
