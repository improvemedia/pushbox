# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  self.table_name_prefix = "pushbox_"
end
