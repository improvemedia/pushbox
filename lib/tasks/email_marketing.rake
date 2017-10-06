namespace :email_marketing do
  Letter.some_scope.find_each do |letter|
    EmailService.build(letter: letter)
  end
end