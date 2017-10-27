# frozen_string_literal: true

class MailingForm < BaseForm
  form_name :mailing

  attribute :mailing

  attribute :title,       String
  attribute :template_id, Integer
  attribute :segment_id,  Integer
  attribute :dispatch_at, Time

  def persist
    mailing.update(mailing_attributes)
  end

  delegate :id, :errors, :persisted?, to: :mailing

  def segment_collection
    []
  end

  def template_collection
    []
  end

  private

  def mailing_attributes
    attributes
      .slice(:title, :segment_id, :dispatch_at)
      .merge(pushbox_template_id: template_id)
      .compact
  end
end
