# frozen_string_literal: true

# rubocop:disable Rails/ApplicationRecord
class JarvisRecord < ActiveRecord::Base
  self.abstract_class = true

  def readonly?
    true
  end

  def destroy
    raise ActiveRecord::ReadOnlyRecord
  end
end
# rubocop:enable Rails/ApplicationRecord
