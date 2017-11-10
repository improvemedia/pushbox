# frozen_string_literal: true

require 'sidekiq/web'
Rails.application.routes.draw do
  root 'home#show'

  mount Sidekiq::Web => '/sidekiq'

  resources :mailings, except: %i[edit update]
  resources :segments
  resources :templates do
    member do
      get :preview
    end
  end
end
