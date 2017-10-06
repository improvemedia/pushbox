class TemplateForm < BaseForm
  form_name 'template'

  attribute :template

  attribute :title, String
  attribute :body,  String

  def persist
    template.update_attributes(template_attributes)
  end

  def errors
    template.errors
  end

  def persisted?
    !template.new_record?
  end

  def id
    template.id
  end

  private 

  def template_attributes
    attributes.slice(:title, :body)
  end
end