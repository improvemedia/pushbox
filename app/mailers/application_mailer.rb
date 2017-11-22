# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: "Новое на INMYROOM<postmaster@mg.inmyroom.ru>"
  layout "mailer"
end
