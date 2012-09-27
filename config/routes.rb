Fair::Application.routes.draw do

  resources :complaints

  resources :products

  get 'sign_up(/:invitation)' => 'login#sign_up'
  post 'sign_up' => 'login#create'
  get 'sign_in' => 'login#sign_in'
  post 'sign_in' => 'login#authenticate'
  match 'sign_out' => 'login#sign_out'
  post 'check' => 'login#check'

  get 'home' => 'subscribers#home'

  get 'invite' => 'subscribers#invite'
  post 'invite' => 'subscribers#deliver'
  get 'profile' => 'subscribers#edit'
  get 'password' => 'subscribers#password'
  get 'payment_password' => 'subscribers#payment_password'
  put 'profile' => 'subscribers#update'
  put 'password' => 'subscribers#update_password'
  put 'payment_password' => 'subscribers#update_payment_password'

  get 'regions/:id' => 'regions#index'

  get 'authorize/email' => 'subscribers#initiate_authorizing_email'
  get 'authorize' => 'subscribers#finish_authorizing_email'

  get 'reset_password' => 'login#initiate_reset_password'
  post 'reset_password' => 'login#deliver_reset_password'
  get 'reset_password/:code' => 'login#reset_password', :as => :reset_password_code
  put 'reset_password/:code' => 'login#finish_reset_password'

  resources :resources, :only => [ :create ]
  resources :shipping_addresses
  resources :returnings
  resources :bookmarks, :except => [ :new, :edit, :update ]
  resources :announcements, :only => [ :index, :show ]
  resources :notifications, :only => [ :index, :show ]
  resources :reviews
  resources :reports

  put 'notifications/:id/read' => 'notifications#read', :as => :read_notification
  delete 'notifications/:id' => 'notifications#stash'

  namespace :admin do
    resources :landing_pages
    resources :returnings, :only => [ :index, :show ]
    resources :complaints, :only => [ :index, :show ]
    resources :reports, :only => [ :index, :show ]
    resources :announcements
    resources :notifications

    get 'returnings/:id/accept' => 'returnings#accept', :as => :accept_returning
    put 'returnings/:id/accept' => 'returnings#do_accept'
    get 'returnings/:id/solve' => 'returnings#solve', :as => :solve_returning
    put 'returnings/:id/solve' => 'returnings#do_solve'
    get 'returnings/:id/reject' => 'returnings#reject', :as => :reject_returning
    put 'returnings/:id/reject' => 'returnings#do_reject'
    put 'complaints/:id/accept' => 'complaints#accept', :as => :accept_complaint
    get 'complaints/:id/edit' => 'complaints#edit', :as => :edit_complaint
    put 'complaints/:id/finish' => 'complaints#finish', :as => :finish_complaint
    put 'reports/:id/accept' => 'reports#accept', :as => :accept_report
    put 'reports/:id/finish' => 'reports#finish', :as => :finish_report

    get 'sign_in' => 'login#sign_in'
    post 'sign_in' => 'login#authenticate'
    match 'sign_out' => 'login#sign_out'
  end
  
  resources :orders
  
  resources :shopping do
    collection do
      get 'cart'
      get 'order'
      post 'save_order'
      get 'direct_order'
      get 'edit_address'
      put 'update_address'
      get 'new_address'
      post 'save_address'
    end
  end
  
  get "pays/new"
  get "pays/pay"
  get "pays/success"
  
  post "pays/alipay_notify"
  get  "pays/alipay_done"
  get  "pays/tenpay_done"

  root :to => 'products#index'
end
