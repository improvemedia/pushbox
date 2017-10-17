# frozen_string_literal: true

class Array
  def blank_compact
    select(&:present?)
  end
end
