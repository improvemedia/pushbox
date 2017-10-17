# frozen_string_literal: true

class MailingDispatcherWorker
  include Sidekiq::Worker

  sidekiq_options retry: false

  def perform(mailing_id)
    MailingDispatcherService.dispatch_async(mailing_id: mailing_id)
  end
end
