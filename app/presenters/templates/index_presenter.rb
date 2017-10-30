# frozen_string_literal: true

module Templates
  class IndexPresenter < ApplicationPresenter
    class TemplateEntity < BaseEntity
      attribute :title
      attribute :state
      attribute :edit_url
      attribute :preview_url
      attribute :destroy_url
    end

    def template_entities
      templates.map do |template|
        TemplateEntity.new(
          title: template.title,
          state: template.state,
          edit_url: r.edit_template_path(template),
          preview_url: r.preview_template_path(template),
          destroy_url: r.template_path(template),
        )
      end
    end
    memoize :template_entities

    private

    def templates
      Template.all
    end
    memoize :templates

    def active_page_side_nav_item
      :templates
    end
  end
end
