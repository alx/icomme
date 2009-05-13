Merb::Router.prepare do |scope|

  scope.identify DataMapper::Resource => :id do |s|
    s.resources :attributes,     ::Icomme::Attributes
    s.resources :products,       ::Icomme::Products do |r|
      r.resources :attributes,     ::Icomme::Attributes
    end
  end

  scope.match('/search').to(:controller => 'main', :action => 'search').name(:search)
  scope.match('/products').to(:controller => 'main', :action => 'products').name(:products)
  scope.match('/').to(:controller => 'main', :action => 'index').name(:index)

end