require 'spec_helper'

describe GooglePlacesAutocomplete::Client do
  
  it 'should not initialize without an api_key' do
    lambda { GooglePlacesAutocomplete::Client.new }.should raise_error
  end

  it 'should initialize with an api_key' do
    @client = GooglePlacesAutocomplete::Client.new(:api_key => "foobar")
    @client.api_key.should == "foobar"
  end
  
  context "request an autocomplete with location bias", :vcr => { :cassette_name => 'location_bias' } do

    it 'should request autocomplete' do    
      @client = GooglePlacesAutocomplete::Client.new(:api_key => "foobar")
      @autocomplete = @client.autocomplete(:lat => 40.606654, :lng => -74.036865, :input => "coffee", :types => "establishment", :radius => 50)
      @autocomplete.predictions.size.should == 5
      @autocomplete.predictions.first.description.should == "The Coffee Foundry, West 4th Street, New York, NY, United States"
    end
  end

  context "request an autocomplete", :vcr => { :cassette_name => 'autocomplete' } do

    it 'should request autocomplete' do    
      @client = GooglePlacesAutocomplete::Client.new(:api_key => "foobar")
      @autocomplete = @client.autocomplete(:input => "Paris", :types => "geocode")
      @autocomplete.predictions.size.should == 5
      @autocomplete.predictions.first.description.should == 'Paris, France'
    end
  end
  
  context "request an autocomplete with bounds", :vcr => { :cassette_name => 'with_bounds' } do

    it 'should request autocomplete with bounds parameter' do    
      @client = GooglePlacesAutocomplete::Client.new(:api_key => "foobar")
      @autocomplete = @client.autocomplete(:input => "Peter Luger", :types => "establishment", 
                                           :sw_bounds => {:lat => 40.606654, :lng => -74.036865}, 
                                           :ne_bounds => {:lat => 40.744655, :lng => -73.831558})
      
      @autocomplete.predictions.size.should == 2
    end
  end
end