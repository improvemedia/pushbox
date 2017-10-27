# frozen_string_literal: true

module Templates
  class IndexPresenter < ApplicationPresenter
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
end
