Bamc::Application.routes.draw do
  devise_for :users

  namespace :api do
    namespace :version1 do
      resources :users, only: [:index]
      resources :beats, only: [:index]
      resources :tracks, only: [:index]
    end
  end


  # The priority is based upon order of creation:
  # first created -> highest priority.

  ['about', 'team'].each do |page|
    get "/#{page}" => "pages##{page}", :as => page
  end

  namespace :admin do
    resources :beats, only: [:index, :new, :create, :edit, :update] do
      member do
        get 'approve'
        get 'reject'
        get 'reset'
      end
    end
  end

  resources :tracks, only: [:new, :create,:show,:destroy] do
    post 'upload', :on => :collection
    member do
        get 'public'
        get 'private'
        get 'download'
      end
  end

  resources :beatmaker, only: [:new]

  resources :mcs, only: [:show]

  resources :beats, only: [:index] do
    member do
      get 'download'
    end
  end

  resources :dashboard, only: [:index]

  get '/signS3put', to: 'signs#sign'

  # resources :beats, only: [:index, :new, :create] do
  #   collection do
  #     get :approve, :reject, :reset
  #   end
  # end

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
  root :to => 'beats#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
