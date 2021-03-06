Rails.application.routes.draw do
  # Home
  root 'home#index'

  # User - Devise
  devise_for :users

  # Room
  get 'rooms'                   => "rooms#index"
  get 'rooms/:room_id'          => 'rooms#detail',  :constraints => { :room_id => /\d+/ }
  get 'rooms/new'               => 'rooms#new'
  get 'rooms/edit/:room_id'     => 'rooms#edit',    :constraints => { :room_id => /\d+/ }
  get 'rooms/remove/:room_id'   => 'rooms#remove',  :constraints => { :room_id => /\d+/ }

  post 'rooms/create'           => 'rooms#create'
  post 'rooms/update/:room_id'  => 'rooms#update'
  get 'rooms/delete/:room_id'   => 'rooms#delete'
  get 'rooms/complete/:room_id' => 'rooms#complete'

  # Admin
  get 'admin/'                  => 'admin#index'
  get 'admin/users'             => 'admin#users'
  get 'admin/rooms'             => 'admin#rooms'

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
