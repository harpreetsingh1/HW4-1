Rottenpotatoes::Application.routes.draw do
  
  resources :movies do
    match 'similar' => 'movies#similar'
  end
  root :to => 'movies#index'
end


