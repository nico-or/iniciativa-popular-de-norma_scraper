# frozen_string_literal: true

describe ChileConvencion::IniciativaDetails do
  let(:details_aprobada_organizacion) do
    html = load_webpage_fixture('iniciativa_details_aprobada_organizacion')
    described_class.new html
  end

  let(:details_aprobada_personal) do
    html = load_webpage_fixture('iniciativa_details_aprobada_personal')
    described_class.new html
  end

  describe '#respuestas' do
    before do
      @respuestas = details_aprobada_organizacion.respuestas
    end

    it { expect(@respuestas).to be_an Array }
    it { expect(@respuestas).to all be_an String }
    it { expect(@respuestas.count).to be 6 }
  end

  describe '#topic' do
    it do
      topic = 'Seguridad Social y sistema de pensiones'
      expect(details_aprobada_organizacion.topic).to eq(topic)
    end
  end

  context 'iniciativa de organizacion' do
    describe '#author' do
      it do
        author = 'Constanza Burnier A.'
        expect(details_aprobada_organizacion.author).to eq(author)
      end
    end

    describe '#organization' do
      it do
        organization = 'Con Mi Plata NO'
        expect(details_aprobada_organizacion.organization).to eq(organization)
      end
    end
  end

  context 'iniciativa personal' do
    describe '#author' do
      it do
        author = 'M. Soledad Chacón W.'
        expect(details_aprobada_personal.author).to eq(author)
      end
    end

    describe '#organization' do
      it do
        organization = nil
        expect(details_aprobada_personal.organization).to eq(organization)
      end
    end
  end
end
