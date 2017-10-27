# frozen_string_literal: true

namespace :email_marketing do
  task send_emails: :environment do
    MailingRepository.for_send.find_each do |mailing|
      MailingDispatcherJob.perform_later(mailing.id)
    end
  end
end
