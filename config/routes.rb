Patreon::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  resources :search, only: :search do
    collection do
      post :import
      get :autocomplete # <= add this line
    end
  end

  scope '/hooks', controller: :hooks do
    post :new_user_info_callback
    post :new_project_callback
  end

  root 'search#search'

  get 'search' => 'search#search', as: 'search'
  get 'sync' => 'projects#syncPatreon', as: 'get_projects'
  get 'sync-users' => 'users#syncUsers', as: 'get_users'
  get 'add-users' => 'users#addUsersCrawlUrlsToKimono', as: 'step_three'
  get 'add-projects' => 'projects#addCrawlUrlsToKimono', as: 'step_one'
  get 'start-crawl' => 'projects#startCrawl'
  get 'add-projectids' => 'projects#getPatreonIds', as: 'step_two'
  get 'start-projects-crawl' => 'projects#startProjectsCrawl'

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
