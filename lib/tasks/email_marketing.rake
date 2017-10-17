# frozen_string_literal: true

namespace :email_marketing do
  task send_emails: :environment do
    LetterRepository.for_send.find_each do |letter|
      LetterDispatcherWorker.perform_async(letter.id)
    end
  end
end
