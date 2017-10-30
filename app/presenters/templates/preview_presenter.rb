# frozen_string_literal: true

module Templates
  class PreviewPresenter < ApplicationPresenter
    attribute :template, Template

    def template_title
      template.title
    end

    def template_body
      template.body
    end

    private

    def active_page_side_nav_item
      :templates
    end
  end
end
