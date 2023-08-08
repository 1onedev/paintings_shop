Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  scope "(:locale)", locale: /uk|en/ do
    devise_for :users
    devise_for :admins

    namespace :admin do
      resources :orders
      resources :items
      resources :item_categories
      resources :item_materials
      resource  :positions, only: :update
      resources :posts
      resources :authors
      resources :sliders
      resources :comments
      resources :feedbacks
      resources :messages
      resources :answers
      resources :sliders
      resources :partners
      controller :pages do
        get 'notifications', action: :notifications, as: :notifications
        get 'page_content', action: :page_content, as: :page_content
      end
      resources :users
      resource  :settings

      resources :images, only: [:create, :destroy]

      delete 'delete_photos', to: "images#delete_photos"
      
      root to: 'orders#index'
    end

    namespace :user do

      resource :infos

      resources :orders

      root to: 'infos#show'
    end

    resources :item_categories, path: 'painting-categories' do
      resources :items, path: 'paintings', only: :show
    end
    resources :authors, only: :show

    resources :comments, only: :create
    
    resources :posts
    resource  :wishlist
    resources :feedbacks, only: :create
    resources :messages, only: :create
    resource  :cart
    resources :payments, param: :uid
    
    controller :pages do
      get 'about-us', to: :about_us, as: :about_us, action: :about_us
      get 'contact-us', to: :contact_us, as: :contact_us, action: :contact_us
      get 'payments-success', to: :payments_success, as: :payments_success, action: :payments_success
      get 'faqs', to: :faqs, as: :faqs, action: :faqs
      get 'help', to: :help, as: :help, action: :help
    end

    namespace :ajax, defaults: { format: :js } do
      resource :cart
      resource :favorites
    end

    root to: 'home#index'
  end
end
