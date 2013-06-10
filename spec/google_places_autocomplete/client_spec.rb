require 'spec_helper'

vcr_options = { :cassette_name => "autocomplete", :record => :new_episodes }

describe GooglePlacesAutocomplete::Client, :vcr => vcr_options do
  
  describe "#autocomplete" do
    
    context "without api key configured" do
    
      it 'should raise an error if api key is not passed as a parameter' do
        lambda { GooglePlacesAutocomplete::Client.autocomplete(:input => "Paris") }.should raise_error
      end

      it 'should not raise an error if api key is passed as a parameter' do
        lambda { 
          GooglePlacesAutocomplete::Client.autocomplete(
            :input => "Paris",
            :key   => "foobar"
          )
        }.should_not raise_error
      end
    end
    
    context "with api key configured" do
      
      before(:all) do
        GooglePlacesAutocomplete.configure do |c|
          c.api_key = "foobar"
        end
      end
      
      it 'should raise an error if input is not passed as a parameter' do
        lambda { GooglePlacesAutocomplete::Client.autocomplete }.should raise_error
      end
      
      it 'should raise an error if input parameter is nil' do
        lambda { GooglePlacesAutocomplete::Client.autocomplete(:input => nil) }.should raise_error
      end
      
      it 'should raise an error if sensor parameter is nil' do
        lambda { GooglePlacesAutocomplete::Client.autocomplete(:sensor => nil) }.should raise_error
      end
      
      it "should return a string containing the json response from Google" do
        GooglePlacesAutocomplete::Client.autocomplete(:input => "Paris").should be_an_instance_of(String)
      end
    end
  end
end