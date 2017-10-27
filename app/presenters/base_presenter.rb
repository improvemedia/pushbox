# frozen_string_literal: true

class BasePresenter
  extend Memoist

  include Virtus.model
  include WithHelperAndRoutingConcern
end
