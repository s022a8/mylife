Rails.application.routes.draw do
  namespace :admin do
    get 'users/index'
    get 'users/warning'
  end
  get 'static_pages/about'
  get 'static_pages/tos'
  get 'book_marks/index'
  get 'talks/index'
  get 'talks/show'
  get 'histories/index'
  get 'histories/show'
  get 'histories/new'
  get 'histories/edit'
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
