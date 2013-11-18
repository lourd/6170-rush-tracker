Djsmiley0LourdBshaibuMattyhkFinal::Application.routes.draw do
  
  resources :rushees
  resources :actions
  post "rushees/comment" => "rushees#comment"

  get "events/new"
  get "events/edit"
  get "events/delete"
  get "events/" => "events#index"
  get "accounts/" => "accounts#index"
  get "accounts/detail/:id" => "accounts#detail"
  get "accounts/verify/:id" => "accounts#verify" 
  get "accounts/deny/:id" => "accounts#deny" 
  get "accounts/invite"
  post "accounts/invite" => "accounts#processInvite"
  get "rushees/edit" => "rushees#edit"
  get "rushees/delete/:id" => "rushees#delete"
  devise_for :brothers

  match '/presentation', to: 'rushees#present', via: 'get'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root :to => "rushees#index"

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
