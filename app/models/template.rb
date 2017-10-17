# frozen_string_literal: true

class Template < ApplicationRecord
  has_many :letters, dependent: :restrict_with_error
end
