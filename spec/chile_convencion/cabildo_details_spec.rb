require 'nokogiri'

describe ChileConvencion::CabildoDetails do
  let(:cabildo_details) do
    html = load_webpage('cabildo_page')
    described_class.new(html)
  end

  describe '#temas_abordados' do
    subject { cabildo_details.temas_abordados }

    it { should be_an Array }
    it { should all be_a String }
    it do
      temas = [
        'Derechos de las personas mayores',
        'Seguridad Social y sistema de pensiones',
        'Gobiernos locales',
        'Deber de protección, justicia intergeneracional, delitos ambientales y principio de no regresión ambiental',
        'Derecho a la Ciencia, Conocimiento y Tecnología'
      ]
      expect(subject).to eq(temas)
    end
  end
end
