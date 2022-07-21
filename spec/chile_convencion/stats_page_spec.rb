describe ChileConvencion::StatsPage do
  let(:aprobada_stats) do
    html = load_webpage('aprobada_stats')
    described_class.new html
  end

  describe '#data_script_tags' do
    it { expect(aprobada_stats.data_script_tags.count).to eq(9) }
  end

  describe '#entry_regex' do
    let (:regex) { aprobada_stats.entry_regex }

    context 'Entry format [YYYY-mm-dd, Int]' do
      let (:entry) { '[" 2021-12-15",56]' }

      it { expect(regex).to match(entry) }

      it 'captures both values correctly' do
        match = regex.match entry
        expect(match[1]).to eq('2021-12-15')
        expect(match[2]).to eq('56')
      end
    end

    context 'Entry format: [Int, Int]' do
      let (:entry) { '[" 00",1495]' }

      it { expect(regex).to match(entry) }

      it 'captures both values correctly' do
        match = regex.match entry
        expect(match[1]).to eq('00')
        expect(match[2]).to eq('1495')
      end
    end

    context 'Entry format: [String, Int]' do
      let (:entry) { '[" Personas mayores",8642]' }

      it { expect(regex).to match(entry) }

      it 'captures both values correctly' do
        match = regex.match entry
        expect(match[1]).to eq('Personas mayores')
        expect(match[2]).to eq('8642')
      end
    end
  end
end
