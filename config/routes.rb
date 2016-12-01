Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  root 'home#index'

  get '/faqs', to: 'home#faqs', as: :faqs
  get '/about_us', to: 'home#about_us', as: :about_us
  get '/contact_us', to: 'home#contact_us', as: :contact_us

  get '/ingredients', to: 'ingredients#index', as: :ingredients
  post '/find_ingredient', to: 'ingredients#find_ingredient', as: :find_ingredient
  post '/update_inventory', to: 'ingredients#update_inventory', as: :update_inventory
  post '/create_price', to: 'ingredients#create_price', as: :create_price
  post '/get_price', to: 'ingredients#get_price', as: :get_price
  post '/get_ingredients_from_usda', to: 'ingredients#get_ingredients_from_usda', as: :get_ingredients_from_usda

  post '/get_units_from_usda', to: 'units#get_units_from_usda', as: :get_units_from_usda
  post '/get_units_by_ingredient', to: 'units#get_units_by_ingredient', as: :get_units_by_ingredient
  post '/create_units', to: 'units#create_units', as: :create_units

  resources :recipes do
    post 'clone'
    get :autocomplete_ingredient_name, on: :collection
  end
  get '/filter_recipes', to: 'recipes#filter_recipes', as: :filter_recipes
  post '/get_type_of_unit', to: 'recipes#get_type_of_unit', as: :get_type_of_unit
  get '/nutrition_label', to: 'recipes#nutrition_label', as: :nutrition_label
  post '/get_recipe_by_id', to: 'recipes#get_recipe_by_id', as: :get_recipe_by_id
  post '/search_tags', to: 'recipes#search_tags', as: :search_tags

  get '/profile', to: 'profile#index', as: :profile
  
  resources :groups
  post '/group_filter_recipes', to: 'groups#filter_recipes', as: :group_filter_recipes
end
