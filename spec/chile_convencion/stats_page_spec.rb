describe ChileConvencion::StatsPage do
  let(:aprobada_stats) do
    html = load_webpage('aprobada_stats')
    described_class.new html
  end

  describe '#data_script_tags' do
    it { expect(aprobada_stats.data_script_tags.count).to eq(9) }
  end
end
