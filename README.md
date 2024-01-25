# Dog Breed Image Fetcher

## Description

This Ruby on Rails application allows users to enter a dog breed name and fetches a random image of that breed using the Dog API (https://dog.ceo/dog-api/). It demonstrates asynchronous requests in Rails with JavaScript (Stimulus) and showcases handling API responses and error states.

## Features

- Search for dog breeds.
- Asynchronously fetch and display dog breed images.
- Error handling for unknown breeds or API errors.

## System Dependencies & Configuration

- Ruby on Rails
- Stimulus JS
- Tailwind CSS (for styling)
- RSpec (for testing)

## Setup

1. **Clone the Repository**:

   ```sh
   git clone git@github.com:dhiraj14/dog_breed_discovery.git
   cd dog_breed_discovery
   ```

2. **Install Dependencies**:
   ```sh
   bundle install
   yarn install
   ```

## Running the Application

1. **Start the Rails Server**:

   ```sh
   ./bin/dev
   ```

2. **Access the Application**:
   - Open your web browser and navigate to `http://localhost:3000`.

## Running Tests

1. **RSpec Tests**:
   - Run the command:
     ```sh
     bundle exec rspec
     ```

## How to Use the Application

- Enter a dog breed into the input field and click "Submit".
- The application will display a random image of the entered dog breed.
- If the breed is not found or an error occurs, an error message will be displayed.
