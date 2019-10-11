Rails.application.routes.draw do
  ##Devise関連
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    registrations: 'users/registrations'
  }


  ###ルートURL###
  root 'users#index'


  ##エンドユーザ側##
  #UsersController
  resource :users, only: [:show] do  #:editアクションはdeviseがやる
    collection do
      get 'warning'
      delete 'leave'
    end
  end

  #HistoriesController
  resources :users, only: [] do
    resources :histories do
      collection do
        get 'gallery'
      end
    end
  end

  #TalksController
  resources :talks, only: [:index, :show, :create] do
  #MessagesController
    resources :messages, only: [:create]
  end

  #CommentsController
  resources :histories, only: [] do
    resources :comments, only: [:create, :destroy]
  end

  #BookMarksController
  resources :book_marks, only: [:index, :create, :destroy]

  #StaticPagesController
  get '/static_pages/about', to: 'static_pages#about'
  get '/static_pages/tos', to: 'static_pages#tos'
  


  ##管理者側##

  #Admin::UsersController
  namespace :admin do
    get '', to: 'users#index'
    get 'users/:id', to: 'users#show'
    get 'users/:id/warning', to: 'users#warning'
    delete 'users/:id/remove', to: 'users#remove'
  end

  #Admin::TalksController
  namespace :admin do
    resources :users, only: [] do
      resources :talks, only: [:index, :show]
    end
  end

  #Admin::CommentsController
  namespace :admin do
    resources :users, only: [] do
      resources :comments, only: [:index, :destroy]
    end
  end

  #Admin::HistoriesController
  namespace :admin do
    resources :users, only: [] do
      resources :histories, only: [:index, :show, :destroy]
    end
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
