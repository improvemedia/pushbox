# frozen_string_literal: true

class LetterForm < BaseForm
  form_name :letter

  attribute :letter

  attribute :title,       String
  attribute :template_id, Integer
  attribute :segment_id,  Integer
  attribute :start_at,    Date

  def persist
    letter.update(letter_attributes)
  end

  delegate :id, :errors, :persisted?, to: :letter

  def segment_collection
    []
  end

  def template_collection
    []
  end

  private

  def letter_attributes
    attributes
      .slice(:title, :segment_id, :start_at)
      .merge(pushbox_template_id: template_id)
      .compact
  end
end
