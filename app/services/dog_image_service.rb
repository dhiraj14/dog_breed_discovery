require 'net/http'

class DogImageService
  API_BASE_URL = "https://dog.ceo/api/breed".freeze

  class FetchError < StandardError; end

  def initialize(breed)
    @breed = breed
  end

  def fetch_random_image
    response = Net::HTTP.get(URI("#{API_BASE_URL}/#{sanitized_breed_param}/images/random"))
    data = JSON.parse(response)

    raise FetchError, 'Error fetching image' unless data['status'] == 'success'
    data['message']
  end

  def sanitized_breed_param
    @breed.split(" ").reverse.join('/')
  end
end
