# frozen_string_literal: true

namespace :email_marketing do
  task send_emails: :environment do
    MailingRepository.for_send.find_each do |letter|
      MailingDispatcherWorker.perform_async(letter.id)
    end
  end
end
