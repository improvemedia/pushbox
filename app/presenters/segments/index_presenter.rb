# frozen_string_literal: true

module Segments
  class IndexPresenter < ApplicationPresenter
    class SegmentEntity < BaseEntity
      attribute :title
      attribute :edit_url
      attribute :destroy_url
    end

    def segment_entities
      segments.map do |segment|
        SegmentEntity.new(
          title: segment.title,
          edit_url: r.edit_segment_path(segment),
          destroy_url: r.segment_path(segment)
        )
      end
    end

    private

    def segments
      SegmentRepository.all
    end
    memoize :segments

    def active_page_side_nav_item
      :segments
    end
  end
end
