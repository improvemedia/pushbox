# frozen_string_literal: true

module Segments
  class NewPresenter < ApplicationPresenter
    attribute :segment, Segment, default: proc { Segment.new }

    attribute :title,    String
    attribute :user_ids, Array[Integer]

    def segment_form
      SegmentForm.new(segment: segment)
    end
  end
end
