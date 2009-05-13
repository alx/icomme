if defined?(Merb::Plugins)

  $:.unshift File.dirname(__FILE__)

  dependency 'merb-slices', :immediate => true
  Merb::Plugins.add_rakefiles "icomme/merbtasks", "icomme/slicetasks", "icomme/spectasks"

  # Register the Slice for the current host application
  Merb::Slices::register(__FILE__)
  
  # Slice configuration - set this in a before_app_loads callback.
  # By default a Slice uses its own layout, so you can swicht to 
  # the main application layout or no layout at all if needed.
  # 
  # Configuration options:
  # :layout - the layout to use; defaults to :icomme
  # :mirror - which path component types to use on copy operations; defaults to all
  Merb::Slices::config[:icomme][:layout] ||= :icomme
  
  # All Slice code is expected to be namespaced inside a module
  module Icomme
    
    # Slice metadata
    self.description = "E-commerce slice to be integrated inside a Merb application"
    self.version = "1.0.11"
    self.author = "Legodata"
    
    # Stub classes loaded hook - runs before LoadClasses BootLoader
    # right after a slice's classes have been loaded internally.
    def self.loaded
    end
    
    # Initialization hook - runs before AfterAppLoads BootLoader
    def self.init
    end
    
    # Activation hook - runs after AfterAppLoads BootLoader
    def self.activate
    end
    
    # Deactivation hook - triggered by Merb::Slices.deactivate(Icomme)
    def self.deactivate
    end
    
    # Setup routes inside the host application
    #
    # @param scope<Merb::Router::Behaviour>
    #  Routes will be added within this scope (namespace). In fact, any 
    #  router behaviour is a valid namespace, so you can attach
    #  routes at any level of your router setup.
    #
    # @note prefix your named routes with :icomme_
    #   to avoid potential conflicts with global named routes.
    def self.setup_router(scope)
      ::Icomme::Router.setup(scope)
    end
    
  end
  
  require "icomme/router"
  
  # Setup the slice layout for Icomme
  #
  # Use Icomme.push_path and Icomme.push_app_path
  # to set paths to icomme-level and app-level paths. Example:
  #
  # Icomme.push_path(:application, Icomme.root)
  # Icomme.push_app_path(:application, Merb.root / 'slices' / 'icomme')
  # ...
  #
  # Any component path that hasn't been set will default to Icomme.root
  #
  # Or just call setup_default_structure! to setup a basic Merb MVC structure.
  Icomme.setup_default_structure!
  
  # Add dependencies for other Icomme classes below. Example:
  # dependency "icomme/other"
  
end