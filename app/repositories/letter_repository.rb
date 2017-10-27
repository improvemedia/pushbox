# frozen_string_literal: true

class LetterRepository < BaseRepository
  self.model_class = Letter

  delegate_to_instance :find_or_initialize_by

  private

  def default_scope
    Letter.all
  end
end
