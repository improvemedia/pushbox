class Letters::NewPresenter < ApplicationPresenter
  def letter_form
    LetterForm.new
  end
end