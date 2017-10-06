class Templates::IndexPresenter < ApplicationPresenter
  class TemplateEntity < BaseEntity
    attribute :title
  end

  def template_entities
    (1..5).map do |n|
      OpenStruct.new(
        title: "Шаблон #{n}"
      )
    end
  end

  private

  def active_page_side_nav_item
    :templates
  end
end
