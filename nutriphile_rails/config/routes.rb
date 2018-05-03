Rails.application.routes.draw do
  root to: "foods#index"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }, :path => 'accounts'
  resources :users do
    resources :diaries, shallow: true
    # collection do
    #   get :diary_entries
    # end
  end
  get('/date', { to: 'diaries#date'})

  resources :foods

end
