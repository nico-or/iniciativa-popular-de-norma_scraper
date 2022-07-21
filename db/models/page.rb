class Page < Sequel::Model
  require 'zlib'

  def html
    Zlib.gunzip body
  end
end
