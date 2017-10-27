module Models
  module SoftDeletable
    extend ActiveSupport::Concern

    included do
      state_machine initial: :actual do
        event :mark_as_deleted do
          transition actual: :deleted
        end

        event :restore do
          transition deleted: :actual
        end
      end

      scope :actual, -> { with_state(:actual) }
    end
  end
end
