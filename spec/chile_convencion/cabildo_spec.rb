require 'nokogiri'

describe ChileConvencion::Cabildo do
  let(:cabildo) do
    card = Nokogiri(File.read('spec/fixtures/cabildo_card.html'))
    described_class.new(card)
  end
end
