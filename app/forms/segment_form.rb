# frozen_string_literal: true

class SegmentForm < BaseForm
  form_name :segment

  attribute :segment

  attribute :title,    String
  attribute :user_ids, Array[Integer]

  delegate :id, :errors, :persisted?, to: :segment
  delegate_attributes :title, :user_ids, to: :segment

  def persist
    segment.update(segment_attributes)
  end

  def user_collection
    h.options_for_select(
      UserRepository.for_select, segment.user_ids
    )
  end

  private

  def segment_attributes
    attributes.slice(:title, :user_ids)
  end
end
