module GooglePlacesAutocomplete
  
  class Client
    
    BASE_URI = "https://maps.googleapis.com/maps/api/place/autocomplete/json"
    REQUIRED_KEYS = [:input, :sensor, :key]
    
    def self.client
      Thread.current[:client] ||= begin
        client = ::Curl::Easy.new
        client.resolve_mode = :ipv4
        client
      end
    end
    
    def self.autocomplete(params={})
      params = default_params.merge params
      validate_params! params
      client.url = "#{BASE_URI}?#{params.to_query}"
      client.http_get
      client.body_str
    end
    
    def self.reset_default_params
      @default_params = nil
    end
    
    protected
    
    def self.default_params
      @default_params ||= { :sensor => false, :key => ::GooglePlacesAutocomplete.api_key }
    end
    
    def self.validate_params!(params)
      REQUIRED_KEYS.each do |key|
        raise "GooglePlacesAutocomplete: #{key} parameter required." if params[key].nil?
      end
    end
  end
end
