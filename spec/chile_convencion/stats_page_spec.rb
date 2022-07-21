describe ChileConvencion::StatsPage do
  let(:aprobada_stats) do
    html = load_webpage('aprobada_stats')
    described_class.new html
  end
end
