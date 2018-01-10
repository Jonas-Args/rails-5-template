Rails.application.routes.draw do

  api vendor_string: "rails_5_template", default_version: 1 do
    version 1 do
      cache as: 'v1' do
        resource :sessions, only: %w(create show destroy)
        resource :users
        patch 'users/forgot_password', to: 'users#forgot_password'
        patch 'users/reset_password',  to: 'users#reset_password'
      end
    end
  end

  root to: "application#index"
end
