# frozen_string_literal: true

module Mailings
  class IndexPresenter < ApplicationPresenter
    def mailing_entities; end

    private

    def active_page_side_nav_item
      :mailings
    end
  end
end
