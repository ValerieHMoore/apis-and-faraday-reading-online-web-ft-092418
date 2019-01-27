class SearchesController < ApplicationController
  def search
  end

  def foursquare
    begin
    @resp = Faraday.get 'https://api.foursquare.com/v2/venues/search' do |req|
      req.params['client_id'] = 'U0Q5ZVHY1GD5HTOSJS5PBUPN4VIBYTZJFIGII2BDUAJUHT34'
      req.params['client_secret'] = 'IYRLITMBS5VQSOYYM52DKMFFQDIQK4O2KXR4GQXWGERRWAS0'
      req.params['v'] = '20160201'
      req.params['near'] = params[:zipcode]
      req.params['query'] = 'coffee shop'
    end
    body = JSON.parse(@resp.body)
    if @resp.success?
      @venues = body["response"]["venues"]
    else
      @error = body["meta"]["errorDetail"]
    end

  rescue Faraday::ConnectionFailed
    @error = "There was a timeout. Please try again."
  end
  render 'search'
  end
end
