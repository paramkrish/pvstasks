Rails.application.routes.draw do


  #match ':controller(/:action(/:id))(.:format)'
  match "signup" => "users#new",  :via => [:get], :as => 'users_new'
  match "login"  => "sessions#login", :via => [:get], :as => 'sessions_login'
  match "login"  => "sessions#login_attempt", :via => [:post], :as => 'sessions_login_attempt'
  match "logout" => "sessions#logout", :via => [:get], :as => 'sessions_logout'
  match "home" => "sessions#home", :via => [:get], :as => 'sessions_home'
  match "profile" => "sessions#profile", :via => [:get], :as => 'sessions_profile'
  match "setting" => "sessions#setting", :via => [:get], :as => 'sessions_setting'

  match "users" => "users#new" , :via => [:get], :as => 'signup_new'

  #match 'gallery_:id' => 'gallery#show', :via => [:get], :as => 'gallery_show'

  get 'sessions/login'
  get 'sessions/home'
  get 'sessions/profile'
  get 'sessions/setting'
  get 'users/new'

  resources :categories
  resources :tasks
  resources :comments
  resources :users


  resources :tasks do
    resources :comments
  end

  root to: 'tasks#index'
  #root :to => 'sessions#login'


  match '/tasks/toggletaskstatus/:id' => 'tasks#toggletaskstatus', as: 'toggletaskstatus_task', via: :put
  match '/tasks/comment_add_to_tasks' => 'tasks#comment_add_to_tasks', as: 'comment_add_to_tasks_task', via: :put

  get '/tasks/:id/:title' => 'tasks#show', :as => :task_with_title
  get '/categories/:id/:name' => 'categories#show', :as => :category_with_name

  get 'categories/index'

  get 'categories/show'

  get 'categories/edit'

  get 'categories/new'

  get 'categories/update'

  get 'categories/destroy'

  get 'categories/create'

  get 'tasks/index'

  get 'tasks/show'

  get 'tasks/edit'

  get 'tasks/new'

  get 'tasks/update'

  get 'tasks/destroy'

  get 'tasks/create'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
