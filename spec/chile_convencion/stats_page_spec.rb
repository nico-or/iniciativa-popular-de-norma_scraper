# frozen_string_literal: true

describe ChileConvencion::IniciativaStats do
  let(:aprobada_stats) do
    html = load_webpage_fixture('aprobada_stats')
    described_class.new html
  end

  describe '#apoyos_por_fecha' do
    subject { aprobada_stats.apoyos_por_fecha }

    it { should be_an Array }
    it { should all be_an Array }
    it do
      entry = subject.first
      expect(entry.count).to eq(2)
    end
  end
end
