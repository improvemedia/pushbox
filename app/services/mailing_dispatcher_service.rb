# frozen_string_literal: true

class MailingDispatcherService < BaseService
  BATCH_SIZE = 100

  attribute :mailing_id, Integer

  def call
    mailing.start_dispatch!
    (1..total_batches).each do |batch_index|
      SendEmailJob.perform_later(mailing_id, batch_index, BATCH_SIZE)
    end
  end

  private

  def mailing
    MailingRepository.find(letter_id)
  end
  memoize :mailing

  def total_batches
    UserRepository.for_segment(mailing.segment).total_batches(BATCH_SIZE)
  end
end
