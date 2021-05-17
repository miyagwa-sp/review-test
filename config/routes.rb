Rails.application.routes.draw do
  get 'login' => 'login#index'
  post 'login' => 'login#login'
  get '/' => 'top#index'
  post 'logout' => 'login#logout'
end
