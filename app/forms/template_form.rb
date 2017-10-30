# frozen_string_literal: true

class TemplateForm < BaseForm
  form_name :template

  attribute :template

  attribute :title, String
  attribute :body,  String

  delegate :id, :errors, :persisted?, to: :template
  delegate_attributes :title, :body, to: :template

  def persist
    template.update(template_attributes)
  end

  private

  def template_attributes
    attributes.slice(:title, :body)
  end
end
