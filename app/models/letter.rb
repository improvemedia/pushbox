# frozen_string_literal: true

class Letter < ApplicationRecord
  belongs_to :template, optional: true

  def segment
    "mock"
  end
end
