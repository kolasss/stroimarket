Stroimarket::Application.routes.draw do

  resources :products do
    get :custom_category_fields, on: :collection
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
    resources :posts
  end

  namespace :api do
    resources :categories,          only: [:index, :show],  defaults: {format: :json}

    resources :stores,              only: [:index, :show],  defaults: {format: :json} do
      get :services, on: :member
    end

    resources :products,            only: [:show],          defaults: {format: :json} do
      get :popular, on: :collection
    end

    resources :service_categories,  only: [:index, :show],  defaults: {format: :json}
    resources :services,            only: [:show],          defaults: {format: :json}
    resources :posts,               only: [:index, :show],  defaults: {format: :json}
    resources :articles,            only: [:index, :show],  defaults: {format: :json}
    resources :manufacturers,       only: [:index, :show],  defaults: {format: :json}
    resources :search,              only: [:show],          defaults: {format: :json}
  end

  # get '/dashboard' => 'templates#index'
  # get '/task_lists/:id' => 'templates#index'
  get '/templates/:path.html' => 'templates#template', :constraints => { :path => /.+/  }

  # Статьи и документы.
  # get 'articles/*path', to: 'articles#show', as: :article_page

end
