Rails.application.routes.draw do
  devise_for :users
  resources :loans do
    member do
      get 'confirmation'
      patch 'confirmation'
      get 'pay'
      post 'pay'
    end

    collection do
      get 'all'
    end
  end
  resources :awards
  get 'transactions/index'

  get 'welcome/home'

  get 'dashboard/student'

  get 'dashboard/instructor'

  root 'welcome#home'

  get 'students/send_money'
  post 'students/sent_money'
  get 'students/give_bonus'
  post 'students/gave_bonus'

  resources :students
  resources :jobs
  resources :periods do
    collection do
      post 'class_bonus'
    end
    member do
      get 'enter_behavior'
      patch 'update_behavior'
    end
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
