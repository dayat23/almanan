CvAlmannan::Application.routes.draw do

  resources :testimonials, only: [:new, :create], path: 'dashboard/testimoni'
  resources :orders, only: [:index, :new, :create] , path: "checkout"

  resources :contacts, only: [:new, :create] ,path: "kontak"

  # get "dashboards/index"
  get "dynamic_price/:id" => "orders#dynamic_price"

  get "sessions/create"

  get "sessions/destroy"

  match '/detailproduk/:id' => 'pages#detail_product', as: 'detail_product'
  resources :review_products
  resources :line_items
  resources :carts, path: "keranjangbelanja"
  resources :account_members, path: "daftarmember"
  # resources :pages
  resources :dashboards, only: [:index], path: 'dashboard'
  resources :sessions, :only => [:new, :create, :destroy]

  match 'dashboard/cancelorder', to: 'dashboards#cancel_order', as: 'cancelorder'

  match 'hitrank', to: 'pages#hit_rank'
  match 'termurah', to: 'pages#product_cheap', as: 'cheaper'
  match 'termahal', to: 'pages#product_high', as: 'higher'

  match 'dashboard/edituser/:id', to: 'account_members#edit', as: 'edituser'
  match 'dashboard/editpassword', to: 'dashboards#edit_password', as: 'editpassword'
  match 'updatepassword', to: 'dashboards#update_password'
  match 'dashboard/daftarorder', to: 'dashboards#show_order', as: 'daftarorder'

  match 'lupapassword', :to => 'pages#new_password'
  match 'newpass', to: 'pages#create_newpassword'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'

  # resources :categories, only: [:new, :create, :update, :destroy]
  get "dynamic_cities/:id" => "pages#dynamic_cities"
  # get "pages/detail_product"
  # get "pages/index"
  resources :pages, only: [:index], path: '' do
    get '?p=:page', :action => :index, :on => :collection
  end

  root :to => 'pages#index'
  match '/addtocart/:id' => 'line_items#create', as: 'add_to_cart'
  match '/emptycart' => 'carts#destroy', as: 'empty'
  match 'hapusitem/:id' => 'line_items#destroy', as: 'del'
  match "kategori", to: 'pages#kategori'
  
  match "how_order", to: 'pages#how_order', path: "caraorder"
  match "sitemap", to: 'pages#sitemap'
  # match "contact", to: 'pages#contact_us', path: "kontak"
  match 'updatequantity/:id' => 'pages#update_quantity_cart', as: 'updateqty'
  match 'deleteitem/:id' => 'pages#delete_item_cart', as: 'deleteitem'
  match '/kategori/produkdetail/:id' => 'pages#category_detail_view', as: 'kategoridetail'
  match 'kategori/:id' => 'pages#category_detail', as: 'categorydetail'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
  match '*unmatched_route', :to => 'application#raise_not_found!'
end
