class BaseService
  include Virtus.model
  extend Memoist
  extend Callable

  def call
    raise NotImplementedError
  end
end
