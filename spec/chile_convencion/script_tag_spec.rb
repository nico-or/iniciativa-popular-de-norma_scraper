describe ChileConvencion::ScriptTag do
  let(:script_tag) do
    html = load_webpage('script_tag')
    parsed = Nokogiri html
    described_class.new parsed
  end

  describe '#entries' do
    before do
      @entries = script_tag.entries
    end

    it { expect(@entries).to be_an Array }
    it { expect(@entries).to all be_an Array }
  end

  describe 'an individual entry' do
    let(:entry) { script_tag.entries.sample }

    it { expect(entry).to be_an Array }
    it { expect(entry).to all be_an String }
    it 'has 2 elements' do
      expect(entry.count).to eq(2)
    end
  end
end
