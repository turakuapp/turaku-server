class Types::DateTime < Types::BaseScalar
  def coerce_input(value, _context)
    Time.zone.parse(value)
  end

  def coerce_result(value, _context)
    value.utc.iso8601
  end
end
