# frozen_string_literal: true

class Mailing < ApplicationRecord
  include Models::SoftDeletable

  belongs_to :template
  belongs_to :segment, optional: true
end
