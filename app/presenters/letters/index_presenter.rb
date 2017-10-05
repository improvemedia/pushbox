class Admin::Clients::IndexPresenter < Admin::ApplicationPresenter
  class ClientEntity
    include Virtus.model

    attribute :name,                    String
    attribute :is_active,               Boolean
    attribute :listen_chatroom_name,    String
    attribute :moderator_chatroom_name, String
    attribute :edit_url,                String

    def human_active
      is_active ? 'Да' : 'Нет'
    end
  end

  def client_entities
    Client.all.map do |client|
      build_client_entity(client)
    end
  end

  private

  def build_client_entity(client)
    ClientEntity.new(
      name: client.name,
      is_active: client.active,
      edit_url: r.edit_admin_client_path(client),
      listen_chatroom_name: client.chatroom&.name,
      moderator_chatroom_name: client.moderator_chatroom&.name
    )
  end

  def active_page_side_nav_item
    :clients
  end
end
