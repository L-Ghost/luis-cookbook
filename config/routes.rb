Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "recipes#index"
  
  resources :recipes do
    collection do
      get :search
      get :my
    end
    member do
      post :favorite
      delete :unfavorite
    end
  end

  resources :recipe_types
  resources :cuisines
end
