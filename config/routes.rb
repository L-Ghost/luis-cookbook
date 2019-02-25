Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "recipes#index"
  get 'recipes_search', to: "recipes#search"
  
  resources :recipes
  resources :recipe_types
  resources :cuisines
end
