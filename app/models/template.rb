class Template < ApplicationRecord
  def self.table_name
    'pushbox_' + super
  end

  has_many :letters
end