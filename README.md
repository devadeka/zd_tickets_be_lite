# Zendesk FAQs

## Task
Create an application that will list all available articles for the user to select and view in detail. The [front end](https://github.com/devadeka/zd_tickets_fe) application will need to talk to a [proxy API](https://github.com/devadeka/zd_tickets_be) that caches data from Zendesk's FAQs API for an hour.

Ensure the backend is running before the frontend.

## Technology Used
The application was developed on `Ubuntu 18.04`

Modules and Libraries used:
- Ruby v2.6.0
- Sinatra
- [HTTParty](https://github.com/jnunemaker/httparty)
- [Redis](https://github.com/antirez/redis)
- [Rspec](https://github.com/rspec/rspec)

## Installation
First clone repository.

`git clone https://github.com/devadeka/zd_tickets_be_lite`

Install dependencies.

`bundle install`

## Testing
After cloning and installing dependencies.
Ensure internet connection is available as the application makes calls to external APIs.

`bundle exec rspec app_spec.rb`

## Running
After cloning and installing dependencies.
Ensure internet connection is available as the application makes calls to external APIs.

`rackup -s puma -p 3030`

## Design Decisions
A minor design decision was to filter out unnecessary fields in the JSON response. Because the purpose of this API was to cache and forward information to the frontend application, knowing exactly what information the frontend utilises allows this API to only return the needed fields. The advantage of this would be to reduce the payload for the frontend. 

Reducing the payload was also a factor in deciding to hardcode (rather than allow the user to select) the `per_page` value when querying Zendesk's FAQs API. The `per_page` value can be set up to 100, but a value of 10 was chosen so that a response will be processed quicker - the user of the frontend application can make multiple small requests for page information.

## Improvements
Need to mock tests for ZD Articles API client.
