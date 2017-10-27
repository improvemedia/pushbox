module Callable
  def call(*attrs, **named_attrs, &block)
    new(*attrs, **named_attrs, &block).call
  end
end
