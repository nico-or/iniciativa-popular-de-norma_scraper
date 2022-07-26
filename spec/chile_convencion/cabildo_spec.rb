# frozen_string_literal: true

require 'nokogiri'

describe ChileConvencion::Cabildo do
  let(:cabildo) do
    card = Nokogiri(load_webpage_fixture('cabildo_card'))
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

  describe '#tipo' do
    subject { cabildo.tipo }

    it { should eq('Cabildo comunal') }
  end

  describe '#fecha' do
    subject { cabildo.fecha }

    it { should eq('12/01/2022') }
  end

  describe '#modalidad' do
    subject { cabildo.modalidad }

    it { should eq('Presencial') }
  end

  describe '#ubicacion' do
    subject { cabildo.ubicacion }

    it { should eq('Monte Patria') }
  end

  describe '#num_participantes' do
    subject { cabildo.num_participantes }

    it { should eq('11') }
  end

  describe '#download_urls' do
    subject { cabildo.download_urls }
    it { should be_an Array }
    it { should all be_a String }
    it do
      urls = [
        'https://plataforma.chileconvencion.cl/m/cabildos/o/806'
      ]
      expect(subject).to contain_exactly(*urls)
    end
  end
end
