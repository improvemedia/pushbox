# frozen_string_literal: true

class LetterDeliveryService < BaseService
  attribute :mailing_id,  Integer
  attribute :batch_index, Integer
  attribute :batch_size,  Integer

  delegate :template, to: :mailing

  def call
    each_letter do |letter|
      MarketingMailer.marketing_email(letter).deliver_now
      letter.mark_as_sent!
    end
  end

  private

  def mailing
    MailingRepository.find(mailing_id)
  end
  memoize :mailing

  def recievers
    UserRepository.for_segment(mailing.segment).batch(batch_index, batch_size)
  end

  def each_letter
    recievers.find_each do |user|
      letter = LetterRepository.find_or_initialize_by(mailing: mailing, user: user)
      next if letter.sent?

      letter.assign_attributes(
        subject: template.title,
        content: MailContentRendererService.call(template: template, user: user)
      )

      yield letter
    end
  end
end
