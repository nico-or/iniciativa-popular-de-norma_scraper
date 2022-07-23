describe ChileConvencion do
  describe '.load_cabildos' do
    subject { ChileConvencion.load_cabildos }

    it { should be_an Array }
    it { should all be_a ChileConvencion::Cabildo }
    it 'should contain 372 elements' do
      expect(subject.count).to eq(327)
    end
  end
end
