class Templates::EditPresenter < ApplicationPresenter
  attribute :template, Template

  def template_form
    TemplateForm.new(template: template)
  end
end