require 'memoist'

class BasePresenter
  extend Memoist

  include Virtus.model
  include WithHelperAndRoutingConcern
end
