Rails.application.routes.draw do
  devise_for :users

  root to: redirect('/panel')
  scope 'panel' do
    get '(*angular_route)', to: 'panel#index', constraints: lambda {|req| req.format == 'text/html'}
  end

  scope '/api', module: 'api' do
    resources :campaigns, except: [:new, :edit] do
      get 'entries', on: :member
    end
  end
end
