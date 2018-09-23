Rails.application.routes.draw do
  devise_for :users

  root to: 'inventories#index'

  
  resources :inventories do
    collection do
      get :stock_report
    end
  end


  resources :orders, only: %i[index show] do
    collection do
      get :add_to_cart
      get :remove_from_cart
    end
  end

  resources :purchases, except: %i[new create edit update destroy] do
    collection do
      get :generate_bill
      post :generate_purchase_report
      get :purchase_report
    end

    member do
      get :pay_bill
    end
  end

  resources :discounts
end
