# frozen_string_literal: true

class Segment < ApplicationRecord
  include Models::SoftDeletable

  has_many :segment_users, dependent: :restrict_with_error
  has_many :users, through: :segment_users, dependent: :restrict_with_error
end
