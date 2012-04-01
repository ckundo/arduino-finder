ArduinoFinder::Application.routes.draw do
  resources :products, :stores
  root :to => 'stores#index'

end
