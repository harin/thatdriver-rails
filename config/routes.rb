ThatDriver::Application.routes.draw do

  #api reference http://railscasts.com/episodes/350-rest-api-versioning?view=asciicast
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      #get token
      get '/get_token', to: 'api#get_token'
      post '/register', to: 'api#register'

      #taxi related APIs
      get '/get_taxi', to: 'taxis#get_taxi'
      post '/rate_taxi', to: 'taxis#rate_taxi'
      get '/ratings_summary', to: 'taxis#ratings_summary'
      get '/get_ratings', to: 'taxis#get_ratings'

      #item related APIs
      get '/myreports', to: 'items#get_my_report'
      get '/my_lost_and_found', to:'items#get_lost_and_found'
      get '/allreports', to: 'items#get_all_report'
      post '/report_lost', to: 'items#report_lost'
      post '/report_found', to: 'items#report_found'
      post '/resolve_item', to: 'items#resolve_item'
      post '/update_item', to: 'items#update_item'
      post '/delete_item', to: 'items#delete_item'
    end
  end


  resources :found_items

  resources :items
  resources :rates

  resources :taxis

  root :to => 'home#index'

  get "home/index"

  devise_for :users
  resources :users

  # root :to => "/index.html" #for devise

  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
