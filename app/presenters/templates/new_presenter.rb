class Templates::NewPresenter < ApplicationPresenter
  attribute :template, Template, default: Template.new

  attribute :title, String
  attribute :body,  String

  def template_form
    TemplateForm.new(template: template)
  end
end