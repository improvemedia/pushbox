class BaseRepository
  attr_reader :scope

  class << self
    attr_accessor :model_class

    def delegate_to_instance(*methods)
      singleton_class.class_eval do
        delegate(*methods, to: :new)
      end
    end
  end

  delegate :find, to: :scope
  delegate :transaction, to: :model_class
  delegate :model_class, to: :class
  delegate_to_instance :find, :transaction

  def initialize(scope = default_scope)
    @scope = scope
  end

  def method_missing(method_name, *args, &block)
    if scope.respond_to?(method_name)
      result = scope.public_send(method_name, *args, &block)
      if result.is_a?(ActiveRecord::Relation)
        self.class.new(result)
      else
        result
      end
    else
      super
    end
  end

  def respond_to_missing?(method_name, include_private = false)
    scope.respond_to?(method_name, include_private) || super
  end

  private

  def default_scope
    raise NotImplementedError
  end
end
