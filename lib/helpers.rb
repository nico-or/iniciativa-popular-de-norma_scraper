# frozen_string_literal: true

def load_webpage(filename)
  File.read(filename, encoding: 'ISO8859-1:UTF-8')
end
