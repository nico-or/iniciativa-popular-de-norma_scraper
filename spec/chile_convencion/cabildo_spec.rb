require 'nokogiri'

describe ChileConvencion::Cabildo do
  let(:cabildo) do
    card = Nokogiri(File.read('spec/fixtures/cabildo_card.html'))
    described_class.new(card)
  end

  describe '#details_url' do
    path = 'https://plataforma.chileconvencion.cl/m/cabildos/o/806'
    it { expect(cabildo.details_url).to eq(path) }
  end
end
