# frozen_string_literal: true

module UserRepository
  module_function

  def for_segment(_segment)
    model_class.where(type: "User").limit(3000)
  end

  private

  def model_class
    User
  end
end
