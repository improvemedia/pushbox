# frozen_string_literal: true

module Letters
  class NewPresenter < ApplicationPresenter
    attribute :letter, Letter, default: -> { Letter.new }

    attribute :title,       String
    attribute :template_id, Integer
    attribute :segment_id,  Integer
    attribute :start_at,    Date

    def letter_form
      LetterForm.new(letter: letter)
    end
  end
end
