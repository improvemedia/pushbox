# frozen_string_literal: true

class ApplicationPresenter < BasePresenter
  class PageSideNavItemEntity < BaseEntity
    attribute :title,  String
    attribute :url,    String
    attribute :active, Boolean
  end

  class ApplicationLayoutEntity < BaseEntity
    attribute :page_side_nav_item_entities, Array[PageSideNavItemEntity]
  end

  def application_layout_entity
    ApplicationLayoutEntity.new(
      page_side_nav_item_entities: page_side_nav_item_entities
    )
  end

  private

  # rubocop:disable Metrics/MethodLength
  def page_side_nav_item_entities
    [
      {
        title:  "Рассылки",
        url:    r.mailings_path,
        active: active_page_side_nav_item == :mailings
      },
      {
        title:  "Сегменты",
        url:    r.segments_path,
        active: active_page_side_nav_item == :segments
      },
      {
        title:  "Шаблоны",
        url:    r.templates_path,
        active: active_page_side_nav_item == :templates
      }
    ].map { |nav_item| PageSideNavItemEntity.new(nav_item) }
  end
  # rubocop:enable Metrics/MethodLength

  def active_page_side_nav_item
    nil
  end
end
