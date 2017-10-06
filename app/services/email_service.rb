class EmailService
  include Virtus.model
  extend Memoist

  attribute :letter, Letter

  def self.build(letter:)
    new(letter: letter).build
  end

  def build
  end
end
