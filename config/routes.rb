ActionController::Routing::Routes.draw do |map|
  
  map.resources :delayed_jobs, :controller => 'delayed_jobs'
  
end
  