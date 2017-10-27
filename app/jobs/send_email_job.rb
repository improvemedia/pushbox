# frozen_string_literal: true

class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(mailing_id, batch_number, batch_size)
    LetterDeliveryService.call(
      mailing_id: mailing_id, batch_number: batch_number,
      batch_size: batch_size
    )
  end
end
