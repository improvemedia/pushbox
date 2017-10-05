class ::Hash
  def compact
    delete_if do |k, v|
      (v.is_a?(Hash) and v.respond_to?('empty?') and v.compact.empty?) or (v.nil?) or (v.is_a?(String) and v.empty?)
    end
  end
  
  def fetch_with_default(key)
    fetch(key, fetch(:_default))
  end

  def o keys
    keys.split('.').reduce(self) {|m,k| m && m[k] }
  end

  def hmap(&block)
    Hash[self.map {|k, v| block.call(k,v) }]
  end

  def deep_hmap(&block)
    self.hmap { |k,v| v.is_a?(Hash) ? [k, v.deep_hmap(&block)] : block.call(k,v) }
  end

  def transform_values
    result = self.class.new
    each do |key, value|
      result[key] = yield(value)
    end
    result
  end


  def difference(other)
    dup.
      delete_if { |k, v| other[k] == v }.
      merge!(other.dup.delete_if { |k, v| has_key?(k) })
  end
end
