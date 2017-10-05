class BaseDecorator
  include WithHelperAndRoutingConcern

  attr_accessor :object

  def initialize(object)
    self.object = object
  end

end
