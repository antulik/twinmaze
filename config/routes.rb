MoviesOnRails::Application.routes.draw do
  get "people/show"

  get "genres/index"

  get "genres/show"

  get "genres/edit"

  resources :movie_list_items

  resources :movie_lists do
    member do
      post 'delete_movie'
      post 'add_movie'
    end
  end

  resources :ex_tmdb_movies

  get "admin/show"
  match 'admin/update_tmdb' => 'admin#update_tmdb', :method => :post
  match 'admin/update_all_web_stats' => 'admin#update_all_web_stats', :method => :post
  match 'admin/auto_sync_tmdb' => 'admin#auto_sync_tmdb', :method => :post
  match 'admin/sync_youtube_trailer' => 'admin#sync_youtube_trailer', :method => :post
  match 'admin/update_manual_tmdb' => 'admin#update_manual_tmdb', :method => :post
  match 'admin' => 'admin#show'

#  get "twin/index"
  
#  resources :user_twins

  resources :twins do
    member do
      post 'update_twins'
      post 'update_personal_ratings'
      post 'update_genres'
      get 'lists'
      get 'ratings'
    end
  end

  get "search/search"

  resources :user_votes do
    collection do
      post 'vote'
    end
  end

  match 'user/edit' => 'users#edit', :as => :edit_current_user
  match 'signup' => 'users#new', :as => :signup
  match 'logout' => 'sessions#destroy', :as => :logout
  match 'login' => 'sessions#new', :as => :login

  match 'search' => 'search#search', :as => :search
  match 'search/save' => 'search#save', :as => :save_search, :via => :post
  match 'search/delete' => 'search#delete', :as => :delete_search, :method => :post

  match 'user/update_twins' => 'users#update_twins', :as => :update_twins
  match 'user/solve_maze' => 'users#solve_maze', :as => :solve_maze

  match 'profile' => 'twins#profile', :as => :my_profile


  resources :people

  resources :sessions

  resources :users do
    member do
      post 'update_twins'
    end
  end

  resources :movies do
    member do
      get 'detail'
      post 'detail'
      post 'update_rating_votes'
    end
  end

  resources :genres 

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "movies#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
