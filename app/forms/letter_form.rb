class LetterForm < BaseForm
  form_name 'letter'

  attribute :letter

  attribute :title,       String
  attribute :template_id, Integer
  attribute :segment_id,  Integer
  attribute :start_at,    Date

  def url
    r.letter_path(123)
  end

  def segment_collection
    []
  end

  def template_collection
    []
  end
end