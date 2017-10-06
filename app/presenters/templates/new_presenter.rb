class Templates::NewPresenter < ApplicationPresenter
  def template_form
    TemplateForm.new
  end
end