Rails.application.routes.draw do
  get 'searches/search'
  devise_for :users
  root to:'homes#top'
  get "home/about"=>"homes#about",as:"about"
  get "/search" => "searches#search"

  resources:books do
    resource:favorites,only:[:create,:destroy]
    resources:book_comments,only:[:create,:destroy]
  end

  resources:users,only:[:index,:show,:edit,:update] do
    resource:relationships,only:[:create,:destroy]
    get 'followings'=>'relationships#followings',as:'followings'
    get 'followers'=>'relationships#followers',as:'followers'
    get "search_count"=>"users#search_count"
  end

  resources :chats,only:[:show,:create]

  resources:groups do
    get "join" => "groups#join"
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
