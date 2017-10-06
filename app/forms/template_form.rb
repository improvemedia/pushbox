class TemplateForm < BaseForm
  form_name 'template'

  attribute :template

  attribute :title, String
  attribute :body,  String

  def url
    r.template_path(123)
  end
end