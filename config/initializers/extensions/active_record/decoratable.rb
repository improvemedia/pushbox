class ActiveRecord::Base
  module Decoratable
    def d
      @decorator ||= ActiveSupport::Inflector.constantize("#{self.class.to_s}Decorator").new(self)
    end
  end
end
