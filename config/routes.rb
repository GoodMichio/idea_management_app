Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  root "ideas#index" # 一覧ページをルートページに設定
  resources :ideas do   # CRUD操作用のルーティングを自動生成
    member do
      get :confirm_delete
    end
    collection do
      get 'new_entry_manual'
      get 'new_entry_auto'
    end
  end

  #フォームの送信先（action）は/ideas/create_autoになり、ideas_controller.rbのcreate_autoアクションが実行される
  post 'ideas/create_auto', to: 'ideas#create_auto', as: 'create_auto_ideas'
end
