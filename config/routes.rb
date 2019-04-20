Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	root to: 'images#input'
	post 'download' => 'images#download', as:'download'
	resources :images, only: [:index]
end
