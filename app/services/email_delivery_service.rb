class EmailDeliveryService
  include Virtus.model
  extend Memoist

  attribute :user_data, Hash
  attribute :template_id, Integer

  def self.deliver(user_data:, template_id:)
    new(user_data: user_data, template_id: template_id).deliver
  end

  def deliver
    email = render_email
    send_email(email)
  end

  private

  def render_email
  end

  def send_email(email)
  end
end
