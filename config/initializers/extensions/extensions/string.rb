class ::String
  def is_num?
    to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end

  def translit
    Russian::translit(self)
  end

  def sklonit(*args)
    DeclensionSolverService.new(self).sklonit(*args)
  end
end
