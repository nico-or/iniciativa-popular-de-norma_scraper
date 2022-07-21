# frozen_string_literal: true

require 'sequel'

DB = Sequel.sqlite('db/iniciativas.sqlite')
Dir['./db/models/*.rb'].sort.each { |f| require f }
