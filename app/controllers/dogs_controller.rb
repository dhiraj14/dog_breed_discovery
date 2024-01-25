class DogsController < ApplicationController
  def fetch_image
    image_url = DogImageService.new(params[:breed]).fetch_random_image
    render json: { image_url: image_url }
  end
end
