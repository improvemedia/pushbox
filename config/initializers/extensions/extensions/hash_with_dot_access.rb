class HashWithDotAccess < HashWithIndifferentAccess
  def method_missing m
    self[m.to_s]
  end
end
