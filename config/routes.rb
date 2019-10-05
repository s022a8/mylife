Rails.application.routes.draw do
  
  ###ルートURL###
  root 'users#index'


  ##Devise関連


  ##エンドユーザ側##
  #UsersController
  resource :users, only: [:show, :edit, :update] do
    collection do
      get 'warning'
      delete 'leave'
    end
  end

  #HistoriesController
  resources :users, only: [] do
    resources :histories
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
    get 'users/:id/warning', to: 'users#warning'
    delete 'users/:id/remove', to: 'users#remove'
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
