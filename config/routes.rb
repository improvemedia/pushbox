# frozen_string_literal: true

Rails.application.routes.draw do
  root 'home#show'

  resources :mailings, except: %i[edit update]
  resources :segments
  resources :templates
end
