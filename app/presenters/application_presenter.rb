class Admin::ApplicationPresenter < BasePresenter
  def application_layout_entity
    OpenStruct.new(
      page_side_nav_item_entities: page_side_nav_item_entities
    )
  end

  private

  def page_side_nav_item_entities
    [
      {
        title: 'Комнаты',
        url: r.admin_chatrooms_path,
        is_active: active_page_side_nav_item == :chatrooms
      },
      {
        title: 'Клиенты',
        url: r.admin_clients_path,
        is_active: active_page_side_nav_item == :clients
      }
    ].map { |nav_item| OpenStruct.new(nav_item) }
  end

  def active_page_side_nav_item
    nil
  end
end