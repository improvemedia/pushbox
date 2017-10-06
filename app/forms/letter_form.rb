class LetterForm < BaseForm
  form_name 'letter'

  attribute :letter

  attribute :title,       String
  attribute :template_id, Integer
  attribute :segment_id,  Integer
  attribute :start_at,    Date

  def persist
    letter.update_attributes(letter_attributes)
  end

  def errors
    letter.errors
  end

  def persisted?
    !letter.new_record?
  end

  def id
    letter.id
  end

  def segment_collection
    []
  end

  def template_collection
    []
  end

  private

  def letter_attributes
    attributes.slice(:title, :segment_id, :start_at).merge(pushbox_template_id: template_id).compact
  end
end