Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :feeds, only: [:index] do
    get 'tag/:tag_name', action: :tag, on: :collection, as: :tag
  end
end
