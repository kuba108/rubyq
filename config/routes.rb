Rails.application.routes.draw do

  devise_for :admin_users, path: 'admin', path_names: { sign_in: 'prihlaseni', sign_out: 'odhlaseni', password: 'zmena-hesla'}

  root "pages#show"

  # Admin routes
  namespace :admin do
    resource :dashboard, only: [:show], path: '', controller: 'dashboard'
    resources :admin_users do
      resources :admin_user_policies, only: [:index] do
        put 'update-acl', to: 'admin_user_policies#update', on: :collection
      end
    end
    resources :routes, only: [:update, :destroy]
    resources :pages do
      resources :sections, shallow: true
      put 'update-sections-order', to: 'pages#update_sections_order'
      put 'update-wrappers-order', to: 'pages#update_wrappers_order'
      put 'update-wrapper-widgets', to: 'pages#update_wrapper_widgets'
    end
    resources :wrappers
    resources :page_contents, only: [:update]
    resources :wrapper_widgets, only: [:create, :destroy]
    resources :widgets
    resources :menus
    resources :menu_items, only: [:create, :update, :destroy]
    resources :galleries do
      resources :gallery_items, only: [:create, :update]
      put 'update-gallery-items-order', to: 'galleries#update_gallery_items_order', on: :member
    end
    resources :gallery_items, only: [:destroy]
    resources :reviews, only: [:index, :show, :new, :create, :update, :destroy]
    resources :settings, only: [:index, :update, :create] do
      put 'set-home-page', to: 'settings#set_home_page', on: :collection
    end
  end

  # Dynamic error pages
  get "/404", to: "errors#not_found"
  get "/422", to: "errors#unacceptable"
  get "/500", to: "errors#internal_error"

  # Permalink routing
  get '/:permalink', to: 'pages#show', as: :page


end
