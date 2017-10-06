module LetterRepository

  def self.for_send
    model_class.all
  end

  def self.find(id)
    model_class.find(id)
  end

  private

  def self.model_class
    Letter
  end
end