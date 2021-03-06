Rails.application.routes.draw do
=begin
  get 'servers', to: 'servers#index'
  post 'servers/create', to: 'servers#create'
  post 'servers/destroy', to: 'servers#destroy'
  get 'domains', to: 'domains#index'
  post 'domains/create', to: 'domains#create'
  post 'domains/destroy', to: 'domains#destroy'
  get 'records', to: 'records#index'
  post 'records/create', to: 'records#create'
  post 'records/destroy', to: 'records#destroy'
  get 'records/ajax_search', to: 'records#ajax_search'
=end

  namespace :v1 do
    get 'servers', to: 'servers#index'
    post 'servers/create', to: 'servers#create'
    delete 'servers/destroy', to: 'servers#destroy'
    get 'domains', to: 'domains#index'
    post 'domains/create', to: 'domains#create'
    delete 'domains/destroy', to: 'domains#destroy'
    get 'domains/ajax_search', to: 'domains#ajax_search'
    get 'records', to: 'records#index'
    post 'records/create', to: 'records#create'
    delete 'records/destroy', to: 'records#destroy'
    get 'records/ajax_search', to: 'records#ajax_search'
  end
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
