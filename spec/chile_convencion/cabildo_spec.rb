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

  describe '#id' do
    subject { cabildo.id }

    it { should eq('806') }
  end

  describe '#nombre' do
    subject { cabildo.nombre }

    it { should eq('Cabildo Monte Patria. Perspectivas de personas mayores.') }
  end
end
