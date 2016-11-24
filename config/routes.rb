Rails.application.routes.draw do
  root 'school#index'

  resources :schools do
	  resources :classrooms
	end
end
