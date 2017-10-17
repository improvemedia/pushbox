# frozen_string_literal: true

Rails.application.routes.draw do
  resources :templates
  resources :letters
end
