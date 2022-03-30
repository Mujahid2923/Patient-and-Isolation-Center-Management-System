Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users
  resources :announcements
  resources :users do
    get 'dashboard'
  end
  resources :patients
  resources :facilities do
    get 'patients/list'
    get 'patients/active'
    get 'patients/recovered'
    get 'patients/transfered'
  end
  resources :invitations
  get 'pages/empty'
end
