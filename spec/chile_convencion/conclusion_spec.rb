# frozen_string_literal: true

describe ChileConvencion::Conclusion do
  let(:cabildo_details) do
    array = [
      "Conclusión 1 4 - Derechos Fundamentales\n",
      'Tema: Derechos de las personas mayores',
      'lorem ipsum'
    ]
    described_class.new(array)
  end

  describe '#comision' do
    subject { cabildo_details.comision }
    it { should eq('4 - Derechos Fundamentales') }
  end

  describe '#tema' do
    subject { cabildo_details.tema }
    it { should eq('Derechos de las personas mayores') }
  end

  describe '#texto' do
    subject { cabildo_details.texto }
    it { should eq('lorem ipsum') }
  end
end
