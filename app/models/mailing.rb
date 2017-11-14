# frozen_string_literal: true

class Mailing < ApplicationRecord
  include Models::SoftDeletable

  belongs_to :template
  belongs_to :segment, optional: true
  has_many :sent_letters, -> { with_state(:sent) },
           class_name: "Letter", dependent: :restrict_with_error

  state_machine :dispatch_state, initial: :pending do
    event :start_dispatch do
      transition pending: :processed
    end
  end
end
