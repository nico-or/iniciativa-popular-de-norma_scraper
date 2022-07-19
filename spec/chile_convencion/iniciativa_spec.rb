require 'csv'

describe ChileConvencion::Iniciativa do
  let(:iniciativa) do
    entry = CSV.open('spec/fixtures/sample_iniciativa_popular.csv', headers: true)
    described_class.new entry.first
  end

  describe '#details_url' do
    it do
      url = 'https://plataforma.chileconvencion.cl/m/iniciativa_popular/detalle?id=71002'
      expect(iniciativa.details_url).to eq(url)
    end
  end

  describe '#stats_url' do
    it do
      url = 'https://plataforma.chileconvencion.cl/m/iniciativa_popular/stats?id=71002'
      expect(iniciativa.stats_url).to eq(url)
    end
  end
end
