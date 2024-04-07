Rails.application.routes.draw do
  scope '/api' do
    resources :features, only: :index do
      post 'comments', on: :member
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
