class Array

  def blank_compact
    select { |i| i.present? }
  end
end
