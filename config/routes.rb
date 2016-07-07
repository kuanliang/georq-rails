Rails.application.routes.draw do
  resources :items

   resources :audit_month
   resources :audit_months
   resources :lead_auditors
  resources :tags
  resources :companies
  #match '/audits/index', :controller => 'audits', :action => "index"

 
  resources :audits  do
    collection { post :import }
    collection { post :waitaudit }
    collection { post :waitgetreport }
    collection { post :waitreport }
    collection { post :waitcertificate }
    collection { post :waitsendcertificate }
    collection { post :senddate }
    member do 
        post :getreport
    end
     member do 
        post :sendreport
    end
    match 'advanced_search' => 'audits#advanced_search',
          on: :collection, via: [:get, :post], as: :advanced_search
    
  end
  resources :projects do
    collection { post :import }

  end

  resources :forms
  
  resources :certificates do

    collection { post :asr }
    collection { post :senddate }
    member do 
        post :sendcertificate
    end
     member do 
        post :getcertificate
    end
  end 


  namespace :account do
    resources :groups
    resources :posts
    resources :projects
  end

  
  resources :services

  devise_for :users
  #root 'groups#index' #這行代表把 localhost:3000/groups 這個網址設成首頁
  root 'customers#index' #這行代表把 localhost:3000/groups 這個網址設成首頁
  #resources :customers
  resources :customers do
    
    collection { post :updateall }
    collection { post :history }
    member do 
        post :continue
    end
    
    collection { post :import }
    resources  :audit_months
    resources :customers_tags
    resources :projects do
            
      resources :items_projects

      resources :items
      resources :audits do
        resource :certificate
      end
      resources :consultants do
        resources :consultant_classes
      end
    end
  end


   resources :groups do
    member do
      post :join
      post :quit
    end
     resources :posts
  end
 
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
