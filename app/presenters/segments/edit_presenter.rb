# frozen_string_literal: true

module Segments
  class EditPresenter < ApplicationPresenter
    attribute :segment, Segment

    def segment_form
      SegmentForm.new(segment: segment)
    end
  end
end
