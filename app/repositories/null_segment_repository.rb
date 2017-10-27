module NullSegmentRepository
  def self.users
    UserRepository.all
  end
end
