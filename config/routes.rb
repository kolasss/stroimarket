Stroimarket::Application.routes.draw do


  mount Ckeditor::Engine => '/ckeditor'
  resources :categories, only: [:index, :show]
  resources :posts

  resources :products do
    # get :custom_category_fields, on: :collection
    get :manufacturer_field, on: :collection

    resources :offers, except: [:index, :show]
  end

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Админка.
  namespace :admin do
    root to: :index

    resources :articles do
      post :update_position, on: :collection
    end

    resources :users do
      resources :store_profiles, except: [:index]
    end
    resources :store_profiles, only: [:index]

    resources :categories do
      post :update_position, on: :collection
    end

    resources :service_categories do
      post :update_position, on: :collection
    end

    resources :manufacturers
    resources :services
  end

  get 'catalog', to: 'catalog#index'

  namespace :api do
    # resources :stocks, defaults: {format: :json} do
    #   get :ohlc
    # end
    # get :categories, to: 'categories#index', defaults: {format: :json}
    resources :categories,  only: [:index, :show],  defaults: {format: :json}
    resources :stores,      only: [:index, :show],  defaults: {format: :json}
    resources :products,    only: [:show],          defaults: {format: :json}
  end

  # get '/dashboard' => 'templates#index'
  # get '/task_lists/:id' => 'templates#index'
  get '/templates/:path.html' => 'templates#template', :constraints => { :path => /.+/  }

  # Статьи и документы.
  get 'articles/*path', to: 'articles#show', as: :article_page

end
