class DogsController < ApplicationController
  before_action :validate_breed_param

  def fetch_image
    image_url = DogImageService.new(breed_param).fetch_random_image
    render json: { image_url: image_url }
  end

  private

  def breed_param
    params[:breed]
  end

  def validate_breed_param
    render json: { error: 'Breed parameter is required' }, status: :bad_request unless breed_param.present?
  end
end
