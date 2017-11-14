# frozen_string_literal: true

class MailingRepository < BaseRepository
  self.model_class = Mailing

  delegate_to_instance :for_send

  def for_send
    self.class.new(
      scope
        .with_dispatch_state(:pending)
        .where("dispatch_at <= ?", Time.current)
    )
  end

  private

  def default_scope
    model_class.actual
  end
end
