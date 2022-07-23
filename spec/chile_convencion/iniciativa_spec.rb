require 'httparty'

describe ChileConvencion::Iniciativa do
  let(:iniciativa_aprobada) { load_iniciativa_card('aprobada', 'popular') }
  let(:iniciativa_rechazada) { load_iniciativa_card('rechazada', 'popular') }
  let(:iniciativa_indigena) { load_iniciativa_card('indigena', 'indigena') }
  let(:iniciativa_indigena_aprobada) { load_iniciativa_card('indigena_aprobada', 'indigena') }

  describe '#id' do
    it { expect(iniciativa_aprobada.id).to eq('8590') }
  end

  describe '#title' do
    it do
      title = 'CON MI PLATA NO - DEFIENDE TUS AHORROS PREVISIONALES'
      expect(iniciativa_aprobada.title).to eq(title)
    end
  end

  describe '#commission' do
    it do
      commission = 'Derechos Fundamentales'
      expect(iniciativa_aprobada.commission).to eq(commission)
    end
  end

  describe '#publication_date' do
    it do
      # publication time = '2021-12-15 16:13:42'
      publication_date = '15/12/2021'
      expect(iniciativa_aprobada.publication_date).to eq(publication_date)
    end
  end

  describe '#support_count' do
    it do
      support_count = 60852
      expect(iniciativa_aprobada.support_count).to eq(support_count)
    end
  end

  describe '#type' do
    context 'iniciativa popular aprobada' do
      it { expect(iniciativa_aprobada.type).to eq('popular') }
    end
    context 'iniciativa popular rechazada' do
      it { expect(iniciativa_rechazada.type).to eq('popular') }
    end
    context 'iniciativa indigena' do
      it { expect(iniciativa_indigena.type).to eq('indigena') }
    end
  end

  context 'Forwards to @details_page' do
    describe '#topic' do
      it do
        topic = 'Seguridad Social y sistema de pensiones'
        expect(iniciativa_aprobada.topic).to eq(topic)
      end
    end

    describe '#author' do
      it do
        author = 'Constanza Burnier A.'
        expect(iniciativa_aprobada.author).to eq(author)
      end
    end

    describe '#organization' do
      it do
        organization = 'Con Mi Plata NO'
        expect(iniciativa_aprobada.organization).to eq(organization)
      end
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
        expect(iniciativa_indigena_aprobada.aprobada?).to be false
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
