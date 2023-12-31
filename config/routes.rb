Rails.application.routes.draw do
  devise_for :admins, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions',
  }

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    resources :end_users, only: [:index, :show, :edit, :update]
  end

  devise_for :end_users, skip: [:passwords], controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
    passwords: 'public/passwords'
  }

  devise_scope :end_user do
    # ゲストログイン用
    post 'end_users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root to: 'homes#top'
    # get 'end_users/mypage' => 'end_users#show', as: 'mypage'
    # end_users/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えている。
    get 'end_users/information/edit' => 'end_users#edit', as: 'edit_information'
    patch 'end_users/information' => 'end_users#update', as: 'update_information'
    get 'end_users/unsubscribe' => 'end_users#unsubscribe', as: 'confirm_unsubscribe'
    put 'end_users/information' => 'end_users#update'
    patch 'end_users/withdraw' => 'end_users#withdraw', as: 'withdraw_end_user'

    resources :posts, only: [:new, :index, :show, :edit, :create, :update, :destroy] do
      resources :post_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    resources :end_users do
      member do
        get :favorites
        get :followings
        get :followers
      end
    end

    # フォロー機能
    resources :end_users do
      resource :follows, only: [:create, :destroy]
      # get 'followings' => 'follows#followings', as: 'followings'
      # get 'followers' => 'follows#followers', as: 'followers'
    end

  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # 検索機能
  get '/search', to: 'searchs#search'


end
