require_relative './active_record/decoratable'

class ActiveRecord::Base
  include Decoratable
end
