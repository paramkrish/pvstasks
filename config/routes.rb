Rails.application.routes.draw do

  resources :categories
  resources :tasks
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
