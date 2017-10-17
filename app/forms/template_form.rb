# frozen_string_literal: true

class TemplateForm < BaseForm
  form_name :template

  attribute :template

  attribute :title, String
  attribute :body,  String

  def persist
    template.update(template_attributes)
  end

  delegate :id, :errors, :persisted?, to: :template

  private

  def template_attributes
    attributes.slice(:title, :body)
  end
end
