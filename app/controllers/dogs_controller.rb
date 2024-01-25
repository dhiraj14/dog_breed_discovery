require 'net/http'

class DogsController < ApplicationController
  def fetch_image
    breed = params[:breed]
    url = URI("https://dog.ceo/api/breed/#{breed}/images/random")
    response = Net::HTTP.get(url)
    data = JSON.parse(response)
    render json: { image_url: data["message"] }
  end
end
