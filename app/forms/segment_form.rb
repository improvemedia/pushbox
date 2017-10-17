# frozen_string_literal: true

class SegmentForm < BaseForm
  form_name :segment

  attribute :segment

  attribute :title,    String
  attribute :user_ids, Array[Integer]

  def persist
    segment.update(segment_attributes)
  end

  delegate :id, :errors, :persisted?, to: :segment

  def user_collection
    User.limit(10).pluck(:first_name, :id)
  end

  private

  def segment_attributes
    attributes.slice(:title, :user_ids)
  end
end
