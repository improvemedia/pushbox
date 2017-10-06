class ApplicationPresenter < BasePresenter
  def application_layout_entity
    OpenStruct.new(
      page_side_nav_item_entities: page_side_nav_item_entities
    )
  end

  private

  def page_side_nav_item_entities
    [
      {
        title: 'Рассылки',
        url: r.letters_path,
        is_active: active_page_side_nav_item == :letters
      },
      {
        title: 'Шаблоны',
        url: r.templates_path,
        is_active: active_page_side_nav_item == :templates
      }
    ].map { |nav_item| OpenStruct.new(nav_item) }
  end

  def active_page_side_nav_item
    nil
  end
end