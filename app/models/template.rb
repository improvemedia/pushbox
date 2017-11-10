# frozen_string_literal: true

class Template < ApplicationRecord
  include Models::SoftDeletable

  has_many :mailings, dependent: :restrict_with_error




  def render(data = {})
    ContentRenderService.call(content: body, data: data)
  end
end
