Rails.application.routes.draw do
  root to: "application#index" 

  resource :application, controller: :application do
    collection do
      get :index
      put :record
      put :set_device
    end
  end
end
