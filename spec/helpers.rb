module ChileConvencionHelpers
  def load_iniciativa(type)
    entry = CSV.open("spec/fixtures/iniciativa_#{type}.csv", headers: true)
    ChileConvencion::Iniciativa.new entry.first
  end
end
