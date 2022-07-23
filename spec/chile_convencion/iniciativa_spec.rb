require 'httparty'

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

      it 'should return a 200 status when sending a GET request to #details_url', slow: true do
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

      it 'should return a 200 status when sending a GET request to #details_url', slow: true do
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
    context 'iniciativa indigena' do
      it do
        expect(iniciativa_indigena.aprobada?).to be false
      end
    end
    context 'iniciativa indigena con id aprobada' do
      it do
        iniciativa = load_iniciativa('indigena_aprobada', 'indigena')
        expect(iniciativa.aprobada?).to be false
      end
    end
  end

  describe '#indigena?' do
    context 'iniciativa popular' do
      it do
        expect(iniciativa_aprobada.indigena?).to be false
      end
    end

    context 'iniciativa indigena' do
      it do
        expect(iniciativa_indigena.indigena?).to be true
      end
    end
  end

  describe '#popular?' do
    context 'iniciativa popular' do
      it do
        expect(iniciativa_aprobada.popular?).to be true
      end
    end

    context 'iniciativa indigena' do
      it do
        expect(iniciativa_indigena.popular?).to be false
      end
    end
  end

  describe '#stats_page?' do
    context 'iniciativa popular aprobada' do
      it do
        expect(iniciativa_aprobada.stats_page?).to eq(true)
      end
    end

    context 'iniciativa popular rechazada' do
      it do
        expect(iniciativa_rechazada.stats_page?).to eq(false)
      end
    end

    context 'iniciativa indigena' do
      it do
        expect(iniciativa_indigena.stats_page?).to eq(false)
      end
    end
  end

  describe '#details_page', focus: true do
    context 'iniciativa popular aprobada' do
      subject { iniciativa_aprobada.details_page }
      it { should be_a ChileConvencion::IniciativaDetails }
    end

    context 'iniciativa popular rechazada' do
      subject { iniciativa_rechazada.details_page }
      it { should be_a ChileConvencion::IniciativaDetails }
    end

    context 'iniciativa indigena' do
      subject { iniciativa_indigena.details_page }
      it { should be_a ChileConvencion::IniciativaDetails }
    end
  end

  describe '#stats_page', focus: true do
    context 'iniciativa popular aprobada' do
      subject { iniciativa_aprobada.stats_page }
      it { should be_a ChileConvencion::IniciativaStats }
    end

    context 'iniciativa popular rechazada' do
      it do
        expect { iniciativa_rechazada.stats_page }.to raise_error(RuntimeError, 'Iniciativa without Stats Page')
      end
    end

    context 'iniciativa indigena' do
      it do
        expect { iniciativa_indigena.stats_page }.to raise_error(RuntimeError, 'Iniciativa without Stats Page')
      end
    end
  end
end
