# frozen_string_literal: true

module Templates
  class EditPresenter < ApplicationPresenter
    attribute :template, Template

    def template_form
      TemplateForm.new(template: template)
    end
  end
end
