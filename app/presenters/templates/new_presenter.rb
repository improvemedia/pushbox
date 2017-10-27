# frozen_string_literal: true

module Templates
  class NewPresenter < ApplicationPresenter
    attribute :template, Template, default: proc { Template.new }

    attribute :title, String
    attribute :body,  String

    def template_form
      TemplateForm.new(template: template)
    end
  end
end
