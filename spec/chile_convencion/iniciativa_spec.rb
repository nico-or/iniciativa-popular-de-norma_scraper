require 'csv'
require 'httparty'

include ChileConvencionHelpers

describe ChileConvencion::Iniciativa do
  let(:iniciativa_aprobada) { load_iniciativa('aprobada', 'popular') }
  let(:iniciativa_rechazada) { load_iniciativa('rechazada', 'popular') }
  let(:iniciativa_indigena) { load_iniciativa('indigena', 'indigena') }

  describe '.initialize' do
    it 'raises when no type is given' do
      expect do
        load_iniciativa('aprobada')
      end.to raise_error(StandardError)
    end

    it 'raises when an invalid type is given' do
      expect do
        load_iniciativa('aprobada', 'foo')
      end.to raise_error(StandardError)
    end

    it 'success when type: popular' do
      expect do
        load_iniciativa('aprobada', 'popular')
      end.not_to raise_error
    end

    it 'success when type: indigena' do
      expect do
        load_iniciativa('aprobada', 'indigena')
      end.not_to raise_error
    end
  end

  describe '#details_url' do
    context 'iniciativa popular' do
      let (:iniciativa) { iniciativa_aprobada }

      it do
        id = iniciativa.id
        url = "https://plataforma.chileconvencion.cl/m/iniciativa_popular/detalle?id=#{id}"
        expect(iniciativa.details_url).to eq(url)
      end

      it do
        req = HTTParty.head iniciativa.details_url
        expect(req.success?).to be true
      end
    end

    context 'iniciativa indigena' do
      let (:iniciativa) { iniciativa_indigena }

      it do
        id = iniciativa.id
        url = "https://plataforma.chileconvencion.cl/m/iniciativa_indigena/detalle?id=#{id}"
        expect(iniciativa.details_url).to eq(url)
      end

      it do
        req = HTTParty.head iniciativa.details_url
        expect(req.success?).to be true
      end
    end
  end

  describe '#stats_url' do
    it do
      iniciativa = iniciativa_aprobada
      id = iniciativa.id
      url = "https://plataforma.chileconvencion.cl/m/iniciativa_popular/stats?id=#{id}"
      expect(iniciativa.stats_url).to eq(url)
    end
  end

  describe '#aprobada?' do
    context 'iniciativa aprobada' do
      it do
        expect(iniciativa_aprobada.aprobada?).to be true
      end
    end
    context 'iniciativa rechazada' do
      it do
        expect(iniciativa_rechazada.aprobada?).to be false
      end
    end
  end
end
