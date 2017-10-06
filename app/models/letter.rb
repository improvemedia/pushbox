class Letter < ApplicationRecord
  def self.table_name
    'pushbox_' + super
  end

  belongs_to :template, optional: true

  scope :some_scope, -> { all }
end