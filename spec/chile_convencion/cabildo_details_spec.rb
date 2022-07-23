require 'nokogiri'

describe ChileConvencion::CabildoDetails do
  let(:cabildo_details) do
    html = load_webpage_fixture('cabildo_page')
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

  describe '#participantes_validadores' do
    subject { cabildo_details.participantes_validadores }
    it do
      validadores = [
        "Álvaro Santos P.", "Brajean Castillo C.", "Gisselle Zamora D.",
        "Claudina Araya R.", "María Urrutia A.", "Gonzalo Soto G.",
        "Priscilla Torres A.", "Álvaro Santos P.", "Brajean Castillo C.",
        "Gisselle Zamora D.", "Claudina Araya R.", "María Urrutia A.",
        "Gonzalo Soto G.", "Priscilla Torres A."
      ]
      expect(subject).to eq(validadores)
    end
  end
end
