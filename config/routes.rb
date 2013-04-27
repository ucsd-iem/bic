Ust::Application.routes.draw do
  get "faq/index"

  get "faq/search"

  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  devise_for :attendees, :path => '', :path_names => {:sign_in => '/abstracts/submit', :sign_out => 'logout'}
  devise_scope :attendee do
    get "/abstracts/submit" => "devise/sessions#new"
  end
  devise_for :users
  
  get "/accommodations" => "pages#accommodations"
  get "/contact" => "pages#contact"
  get "/location" => "pages#location"
  get "/program" => "events#index"
  get "/register" => "registrants#new"
  get "/sponsors" => "pages#sponsors"
  get "/terms" => "pages#terms"
  get "/thanks" => "pages#thanks"
  get "/faq" => "faq#index"
  get "/faq/:q" => "faq#search"
  
  resources :abstracts do
    collection do
      get 'keyword/:keyword' => 'abstracts#keyword', :as => :keyword
      get 'search/:query' => 'abstracts#search', :as => :search
    end
  end

  resources :events
  resources :moderators
  # resources :registrants, :only => [:new, :create, :update]

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  root :to => "pages#home"
  
end
