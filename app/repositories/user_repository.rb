module UserRepository

  def self.for_segment(segment)
    model_class.where(type: 'User').limit(3000)
  end

  private

  def self.model_class
    User
  end
end