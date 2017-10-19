class Letter < ApplicationRecord
  belongs_to :mailing
  belongs_to :user

  state_machine initial: :pending do
    event :mark_as_sent do
      transition pending: :sent
    end
  end
end
