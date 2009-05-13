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
    
    def self.setup_router(scope)
      ::Icomme::Router.setup(scope)
    end
    
  end
  
  Icomme.setup_default_structure!
  use_orm :datamapper

  # Merb dependencies
  merb_version = ">= 1.0.9"
  dependency 'merb-assets',               merb_version
  dependency 'merb-cache',                merb_version
  dependency 'merb-helpers',              merb_version
  dependency 'merb_datamapper',           merb_version
  dependency "merb-mailer",               merb_version
  dependency "merb-param-protection",     merb_version
  dependency "merb-exceptions",           merb_version
  
  # Datamapper dependencies
  dm_version   = ">= 0.9.10"
  dependency "dm-core",           dm_version         
  dependency "dm-aggregates",     dm_version  
  dependency "dm-timestamps",     dm_version
  dependency "dm-is-nested_set",  dm_version
  dependency "dm-is-tree",        dm_version
  
  require "icomme/router"
  
end