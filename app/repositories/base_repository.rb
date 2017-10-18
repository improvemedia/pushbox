class BaseRepository
  mattr_accessor :model_class

  attr_reader :scope

  def self.delegate_to_instance(*methods)
    singleton_class.class_eval do
      delegate(*methods, to: :new)
    end
  end

  delegate :find, to: :scope
  delegate :transaction, to: :model_class
  delegate_to_instance :find, :transaction

  def initialize(scope = default_scope)
    @scope = scope
  end

  def method_missing(method_name, *args)
    if scope.respond_to?(method_name)
      result = scope.public_send(method_name)
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
