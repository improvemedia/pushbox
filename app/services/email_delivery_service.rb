class LetterDispatcherService
  include Virtus.model
  extend Memoist

  attribute :user_id, Integer
  attribute :template_id, Integer

  def self.deliver(user_id:, template_id:)
    new(user_id: user_id, template_id: template_id).deliver
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
