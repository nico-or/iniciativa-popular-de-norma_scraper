describe ChileConvencion::DetailsPage do
  def load_webpage(name)
    File.read("./spec/fixtures/#{name}.html")
  end

  let(:aprobada_details) do
    html = load_webpage('aprobada_details')
    described_class.new html
  end

  describe '#respuestas' do
    before do
      @respuestas = aprobada_details.respuestas
    end

    it { expect(@respuestas).to be_an Array }
    it { expect(@respuestas).to all be_an String }
    it { expect(@respuestas.count).to be 6 }
  end
end
