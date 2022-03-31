Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :announcements
  resources :users do
    get 'dashboard'
    get 'transfers/approve'
  end
  resources :patients do
    get 'transfers/new'
  end
  resources :facilities do
    get 'patients/list'
    get 'patients/active'
    get 'patients/recovered'
    get 'patients/transfered'
  end
  resources :invitations
  get 'pages/empty'
  resources :transfers
end
