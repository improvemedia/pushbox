# frozen_string_literal: true

module Letters
  class IndexPresenter < ApplicationPresenter
    def letter_entities; end

    private

    def active_page_side_nav_item
      :letters
    end
  end
end
