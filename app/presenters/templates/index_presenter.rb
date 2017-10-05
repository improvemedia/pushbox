class Admin::Chatrooms::IndexPresenter < Admin::ApplicationPresenter
  class ChatEntity
    include Virtus.model

    attribute :name
    attribute :human_type
  end

  def chat_entities
    Chatroom.all.map { |chat| map_to_entity(chat) }
  end

  def greeting
    'hello'
  end

  private

  def map_to_entity(chat)
    ChatEntity.new(
      name: chat.name,
      human_type:  chat.d.human_type
    )
  end

  def active_page_side_nav_item
    :chatrooms
  end
end
