# frozen_string_literal: true

class MailingDispatcherJob < ApplicationJob
  queue_as :default

  def perform(mailing_id)
    MailingDispatcherService.call(mailing_id: mailing_id)
  end
end
