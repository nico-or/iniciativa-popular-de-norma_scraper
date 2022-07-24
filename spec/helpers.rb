# frozen_string_literal: true

require 'nokogiri'

def load_webpage(filename)
  File.read(filename, encoding: 'ISO8859-1:UTF-8')
end

def load_webpage_fixture(name)
  load_webpage("./spec/fixtures/#{name}.html")
end

def load_iniciativa_card(name, type)
  html = load_webpage_fixture("#{name}_card")
  parsed = Nokogiri(html)
  ChileConvencion::Iniciativa.new(parsed, type)
end
