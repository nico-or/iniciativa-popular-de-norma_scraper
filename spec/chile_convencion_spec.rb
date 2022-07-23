# frozen_string_literal: true

describe ChileConvencion do
  describe '.load_cabildos' do
    subject { ChileConvencion.load_cabildos }

    it { should be_an Array }
    it { should all be_a ChileConvencion::Cabildo }
    it 'should contain 327 elements' do
      expect(subject.count).to eq(327)
    end
  end

  describe '.load_iniciativas' do
    context 'iniciativas populares' do
      subject { ChileConvencion.load_iniciativas('popular') }

      it { should be_an Array }
      it { should all be_a ChileConvencion::Iniciativa }
      it 'should contain 2496 elements' do
        expect(subject.count).to eq(2496)
      end
    end

    context 'iniciativas indigenas' do
      subject { ChileConvencion.load_iniciativas('indigena') }

      it { should be_an Array }
      it { should all be_a ChileConvencion::Iniciativa }
      it 'should contain 248 elements' do
        expect(subject.count).to eq(248)
      end
    end
  end

  describe '.load_all_iniciativas' do
    subject { ChileConvencion.load_all_iniciativas }

    it { should be_an Array }
    it { should all be_a ChileConvencion::Iniciativa }
    it 'should contain 2744 elements' do
      expect(subject.count).to eq(2744)
    end
  end
end
