module ChewyDecorator

  def d
    @__d ||= ProtectedMethods.find_class(self.class).new(object: self)
  end

  module ProtectedMethods
    def self.find_class(klass)
      decorator_class(klass)
    end

    def self.decorator_class(klass)
      "Documents::#{klass.to_s.demodulize}DocumentDecorator".constantize
    end
  end
end

#class Chewy::Type
  #include ChewyDecorator
#end
