require 'nokogiri'

describe ChileConvencion::CabildoDetails do
  let(:cabildo_details) do
    html = load_webpage('cabildo_page')
    described_class.new(html)
  end
end
