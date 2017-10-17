# frozen_string_literal: true

module Segments
  class IndexPresenter < ApplicationPresenter
    class SegmentEntity < BaseEntity
      attribute :title
    end

    def segment_entities
      []
    end

    private

    def active_page_side_nav_item
      :segments
    end
  end
end
