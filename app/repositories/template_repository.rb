# frozen_string_literal: true

class TemplateRepository < BaseRepository
  self.model_class = Template

  delegate_to_instance :for_select, :all

  def for_select
    scope.pluck(:title, :id)
  end

  private

  def default_scope
    model_class.all
  end
end