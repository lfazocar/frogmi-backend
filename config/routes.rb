Rails.application.routes.draw do
  scope '/api' do
    resources :features, only: :index do
      post 'comments', to: 'features#comment'
      get 'comments', to: 'features#feature_comments'
      get 'comments', to: 'features#all_comments', on: :collection
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
