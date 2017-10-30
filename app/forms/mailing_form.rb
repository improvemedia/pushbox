# frozen_string_literal: true

class MailingForm < BaseForm
  form_name :mailing

  attribute :mailing, Mailing

  attribute :title,       String
  attribute :template_id, Integer
  attribute :segment_id,  Integer
  attribute :dispatch_at, Time

  delegate :id, :errors, :persisted?, to: :mailing
  delegate_attributes :title, :template_id, :segment_id, :dispatch_at, to: :mailing

  def persist
    mailing.update(mailing_attributes)
  end

  def segment_collection
    h.options_for_select(SegmentRepository.for_select, segment_id)
  end

  def template_collection
    h.options_for_select(TemplateRepository.for_select, template_id)
  end

  private

  def mailing_attributes
    attributes
      .slice(:title, :segment_id, :dispatch_at)
      .merge(pushbox_template_id: template_id)
      .compact
  end
end
