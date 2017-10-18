# frozen_string_literal: true

class UserRepository < BaseRepository
  self.model_class = User

  class NullSegment
    def users
      UserRepository.all
    end
  end

  DEFAULT_BATCH_SIZE = 100

  delegate_to_instance :all, :for_select, :for_segment, :total_batches

  def for_select
    scope.pluck("first_name || last_name, id")
  end

  def for_segment(segment)
    self.class.new((segment || NullSegment).users)
  end

  def batch(batch_index, batch_size = DEFAULT_BATCH_SIZE)
    scope.page(batch_index).per(batch_size)
  end

  def total_batches(batch_size = DEFAULT_BATCH_SIZE)
    scope.page(1).per(batch_size).total_pages
  end

  private

  def default_scope
    model_class.where(type: "User")
  end
end
