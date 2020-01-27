Rails.application.routes.draw do
  root "dashboard#index"

  resources :expenses
  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      #     # Directs /admin/products/* to Admin::ProductsController
      #     # (app/controllers/admin/products_controller.rb)
      resources :expenses, only: [:index, :create, :update, :destroy]
    end
  end
end
