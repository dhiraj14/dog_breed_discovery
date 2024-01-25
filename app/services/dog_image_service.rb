require 'net/http'

class DogImageService
  API_BASE_URL = "https://dog.ceo/api/breed".freeze

  def initialize(breed)
    @breed = breed
  end

  def fetch_random_image
    response = Net::HTTP.get(URI("#{API_BASE_URL}/#{@breed}/images/random"))
    data = JSON.parse(response)
    data['message']
  end
end
