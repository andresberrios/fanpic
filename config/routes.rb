Rails.application.routes.draw do
  devise_for :users

  root to: redirect('/panel')
  scope 'panel' do
    get '(*angular_route)', to: 'panel#index', constraints: lambda {|req| req.format == 'text/html'}
  end

  namespace :api do
    resources :campaigns, except: [:new, :edit] do
      resources :entries, except: [:new, :edit]
    end
  end
end
