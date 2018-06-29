Rails.application.routes.draw do

  get 'users/new'
  root 'static_pages#home'
  # get 'static_pages/home'
  # don't need this, as we'll always use 'root_path' or 'root_url' instead

  get 'static_pages/help'
  get 'static_pages/about'

end
