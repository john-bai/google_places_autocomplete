require 'rubygems'
require 'curb'
require 'active_support/core_ext/object/to_query'
require File.join(File.dirname(__FILE__), 'google_places_autocomplete', 'client')

module GooglePlacesAutocomplete
  def self.configure
    yield self
    Client.reset_default_params
    true
  end

  class << self
    attr_accessor :api_key
  end
end

