require 'csv'
include ChileConvencionHelpers

describe ChileConvencion::Iniciativa do
  let(:iniciativa_aprobada) { load_iniciativa('aprobada') }
  let(:iniciativa_rechazada) { load_iniciativa('rechazada') }

  describe '#details_url' do
    it do
      iniciativa = iniciativa_aprobada
      id = iniciativa.id
      url = "https://plataforma.chileconvencion.cl/m/iniciativa_popular/detalle?id=#{id}"
      expect(iniciativa.details_url).to eq(url)
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
